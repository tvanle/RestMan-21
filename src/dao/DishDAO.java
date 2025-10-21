package dao;

import model.Dish;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DishDAO extends DAO {

    /**
     * Search dishes by name
     */
    public List<Dish> searchDishesByName(String name) {
        List<Dish> dishes = new ArrayList<>();
        String sql = "SELECT * FROM Dish WHERE name LIKE ?";

        try {
            Connection conn = getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, "%" + name + "%");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Dish dish = new Dish();
                dish.setId(rs.getInt("id"));
                dish.setName(rs.getString("name"));
                dish.setPrice(rs.getFloat("price"));
                dish.setDescription(rs.getString("description"));
                dish.setCategory(rs.getString("category"));
                dishes.add(dish);
            }

            rs.close();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return dishes;
    }

    /**
     * Get dish by ID
     */
    public Dish getDishById(int id) {
        Dish dish = null;
        String sql = "SELECT * FROM Dish WHERE id = ?";

        try {
            Connection conn = getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                dish = new Dish();
                dish.setId(rs.getInt("id"));
                dish.setName(rs.getString("name"));
                dish.setPrice(rs.getFloat("price"));
                dish.setDescription(rs.getString("description"));
                dish.setCategory(rs.getString("category"));
            }

            rs.close();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return dish;
    }

    /**
     * Get all dishes
     */
    public List<Dish> getAllDishes() {
        List<Dish> dishes = new ArrayList<>();
        String sql = "SELECT * FROM Dish";

        try {
            Connection conn = getConnection();
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);

            while (rs.next()) {
                Dish dish = new Dish();
                dish.setId(rs.getInt("id"));
                dish.setName(rs.getString("name"));
                dish.setPrice(rs.getFloat("price"));
                dish.setDescription(rs.getString("description"));
                dish.setCategory(rs.getString("category"));
                dishes.add(dish);
            }

            rs.close();
            stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return dishes;
    }
}
