package dao;

import model.*;
import java.sql.*;

public class UserDAO extends DAO {

    /**
     * Check login credentials
     */
    public User checkLogin(String username, String password, String role) {
        User user = null;
        String sql = "SELECT * FROM User WHERE username = ? AND password = ?";

        // Add role filter if role is specified
        if (role != null) {
            sql += " AND role = ?";
        }

        try {
            Connection conn = getConnection();

            // Check if connection is null (database not available)
            if (conn == null) {
                System.err.println("Database connection is null. Please check MySQL is running.");
                return null;
            }

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);

            if (role != null) {
                ps.setString(3, role);
            }

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                int id = rs.getInt("id");
                String address = rs.getString("address");
                String userRole = rs.getString("role");
                Timestamp createdAt = rs.getTimestamp("createdAt");

                // Create appropriate user type based on role
                switch (userRole) {
                    case "MANAGER":
                        user = new Manager(id, username, userRole, address, createdAt);
                        break;
                    case "WAREHOUSE_STAFF":
                        user = new WarehouseStaff(id, username, userRole, address, createdAt);
                        break;
                    case "SALE_STAFF":
                        user = new SaleStaff(id, username, userRole, address, createdAt);
                        break;
                    default:
                        user = new User(id, username, userRole, address, createdAt);
                }
            }

            rs.close();
            ps.close();
        } catch (SQLException e) {
            System.err.println("SQL Error in checkLogin: " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            System.err.println("Error in checkLogin: " + e.getMessage());
            e.printStackTrace();
        }

        return user;
    }

}
