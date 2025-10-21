package dao;

import model.Supplier;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SupplierDAO extends DAO {

    /**
     * Search suppliers by name
     */
    public List<Supplier> searchSupplierByName(String name) {
        List<Supplier> suppliers = new ArrayList<>();
        String sql = "SELECT * FROM Supplier WHERE name LIKE ?";

        try {
            Connection conn = getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, "%" + name + "%");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Supplier supplier = new Supplier();
                supplier.setId(rs.getInt("id"));
                supplier.setName(rs.getString("name"));
                supplier.setPhone(rs.getString("phone"));
                supplier.setAddress(rs.getString("address"));
                suppliers.add(supplier);
            }

            rs.close();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return suppliers;
    }

    /**
     * Get supplier by ID
     */
    public Supplier getSupplierById(int id) {
        Supplier supplier = null;
        String sql = "SELECT * FROM Supplier WHERE id = ?";

        try {
            Connection conn = getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                supplier = new Supplier();
                supplier.setId(rs.getInt("id"));
                supplier.setName(rs.getString("name"));
                supplier.setPhone(rs.getString("phone"));
                supplier.setAddress(rs.getString("address"));
            }

            rs.close();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return supplier;
    }

    /**
     * Add new supplier
     */
    public boolean addNewSupplier(Supplier supplier) {
        String sql = "INSERT INTO Supplier (name, phone, address) VALUES (?, ?, ?)";

        try {
            Connection conn = getConnection();
            PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, supplier.getName());
            ps.setString(2, supplier.getPhone());
            ps.setString(3, supplier.getAddress());

            int affectedRows = ps.executeUpdate();

            if (affectedRows > 0) {
                ResultSet generatedKeys = ps.getGeneratedKeys();
                if (generatedKeys.next()) {
                    supplier.setId(generatedKeys.getInt(1));
                }
                generatedKeys.close();
            }

            ps.close();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
