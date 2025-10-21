package dao;

import model.ImportDetail;
import java.sql.*;
import java.util.List;

public class ImportDetailDAO extends DAO {

    /**
     * Add list of import details (used within transaction)
     */
    public boolean addListNewImportDetail(Connection conn, int invoiceId, List<ImportDetail> details) {
        String sql = "INSERT INTO ImportDetail (importInvoice_id, ingredient_id, quantity, unitPrice) VALUES (?, ?, ?, ?)";
        PreparedStatement ps = null;

        try {
            ps = conn.prepareStatement(sql);
            IngredientDAO ingredientDAO = new IngredientDAO();

            for (ImportDetail detail : details) {
                ps.setInt(1, invoiceId);
                ps.setInt(2, detail.getIngredient().getId());
                ps.setFloat(3, detail.getQuantity());
                ps.setFloat(4, detail.getUnitPrice());
                ps.addBatch();

                // Update ingredient stock
                ingredientDAO.updateStockQuantity(detail.getIngredient().getId(), detail.getQuantity());
            }

            int[] results = ps.executeBatch();
            ps.close();

            // Check if all inserts succeeded
            for (int result : results) {
                if (result == Statement.EXECUTE_FAILED) {
                    return false;
                }
            }

            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
