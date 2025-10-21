package dao;

import model.*;
import java.sql.*;

public class ImportInvoiceDAO extends DAO {

    /**
     * Add new import invoice with details
     */
    public boolean addNewImportInvoice(ImportInvoice invoice) {
        Connection conn = null;
        PreparedStatement psInvoice = null;

        try {
            conn = getConnection();
            conn.setAutoCommit(false); // Start transaction

            // Insert ImportInvoice
            String sqlInvoice = "INSERT INTO ImportInvoice (date, totalAmount, supplier_id, warehouseStaff_userid_id) VALUES (?, ?, ?, ?)";
            psInvoice = conn.prepareStatement(sqlInvoice, Statement.RETURN_GENERATED_KEYS);
            psInvoice.setDate(1, invoice.getDate());
            psInvoice.setFloat(2, invoice.getTotalAmount());
            psInvoice.setInt(3, invoice.getSupplier().getId());
            psInvoice.setInt(4, invoice.getWarehouseStaff().getId());

            int affectedRows = psInvoice.executeUpdate();

            if (affectedRows > 0) {
                ResultSet generatedKeys = psInvoice.getGeneratedKeys();
                if (generatedKeys.next()) {
                    int invoiceId = generatedKeys.getInt(1);
                    invoice.setId(invoiceId);

                    // Insert ImportDetails
                    ImportDetailDAO detailDAO = new ImportDetailDAO();
                    boolean detailsAdded = detailDAO.addListNewImportDetail(conn, invoiceId, invoice.getImportDetails());

                    if (detailsAdded) {
                        conn.commit(); // Commit transaction
                        generatedKeys.close();
                        psInvoice.close();
                        return true;
                    }
                }
                generatedKeys.close();
            }

            conn.rollback(); // Rollback if failed
            psInvoice.close();
            return false;

        } catch (SQLException e) {
            e.printStackTrace();
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            return false;
        } finally {
            try {
                if (conn != null) {
                    conn.setAutoCommit(true);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
