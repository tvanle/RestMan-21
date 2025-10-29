package dao;

import model.*;
import java.sql.*;

public class UserDAO extends DAO {

    /**
     * Check login credentials
     */
    public User checkLogin(String username, String role) {
        User user = null;
        String sql = "SELECT * FROM User WHERE username = ? AND role = ?";

        try {
            Connection conn = getConnection();

            // Check if connection is null (database not available)
            if (conn == null) {
                System.err.println("Database connection is null. Please check MySQL is running.");
                return null;
            }

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, role);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                int id = rs.getInt("id");
                String address = rs.getString("address");
                Timestamp createdAt = rs.getTimestamp("createdAt");

                // Create appropriate user type based on role
                switch (role) {
                    case "MANAGER":
                        user = new Manager(id, username, role, address, createdAt);
                        break;
                    case "WAREHOUSE_STAFF":
                        user = new WarehouseStaff(id, username, role, address, createdAt);
                        break;
                    case "SALE_STAFF":
                        user = new SaleStaff(id, username, role, address, createdAt);
                        break;
                    default:
                        user = new User(id, username, role, address, createdAt);
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

    /**
     * Register new user (Customer)
     * @return true if success, false if failed, null if no database connection
     */
    public Boolean registerUser(String username, String fullname, String email, String phone, String password) {
        String sql = "INSERT INTO User (username, role, address, email, phone, password, createdAt) VALUES (?, ?, ?, ?, ?, ?, NOW())";

        try {
            Connection conn = getConnection();

            // Check if connection is null (database not available)
            if (conn == null) {
                System.err.println("Database connection is null. Cannot register user.");
                return null;
            }

            // Check if username already exists
            String checkSql = "SELECT COUNT(*) FROM User WHERE username = ?";
            PreparedStatement checkPs = conn.prepareStatement(checkSql);
            checkPs.setString(1, username);
            ResultSet rs = checkPs.executeQuery();

            if (rs.next() && rs.getInt(1) > 0) {
                rs.close();
                checkPs.close();
                return false; // Username already exists
            }
            rs.close();
            checkPs.close();

            // Insert new user
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, "CUSTOMER"); // Default role
            ps.setString(3, ""); // Address (empty for now)
            ps.setString(4, email);
            ps.setString(5, phone);
            ps.setString(6, password); // Note: In production, should hash password

            int rows = ps.executeUpdate();
            ps.close();

            return rows > 0;

        } catch (SQLException e) {
            System.err.println("SQL Error in registerUser: " + e.getMessage());
            e.printStackTrace();
            return false;
        } catch (Exception e) {
            System.err.println("Error in registerUser: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}
