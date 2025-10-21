package dao;

import model.Ingredient;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class IngredientDAO extends DAO {

    /**
     * Search ingredients by name
     */
    public List<Ingredient> searchIngredientByName(String name) {
        List<Ingredient> ingredients = new ArrayList<>();
        String sql = "SELECT * FROM Ingredient WHERE name LIKE ?";

        try {
            Connection conn = getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, "%" + name + "%");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Ingredient ingredient = new Ingredient();
                ingredient.setId(rs.getInt("id"));
                ingredient.setName(rs.getString("name"));
                ingredient.setStockQuantity(rs.getFloat("stockQuantity"));
                ingredient.setContent(rs.getString("content"));
                ingredient.setUnitPrice(rs.getFloat("unitPrice"));
                ingredient.setCategory(rs.getString("category"));
                ingredients.add(ingredient);
            }

            rs.close();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return ingredients;
    }

    /**
     * Get ingredient by ID
     */
    public Ingredient getIngredientById(int id) {
        Ingredient ingredient = null;
        String sql = "SELECT * FROM Ingredient WHERE id = ?";

        try {
            Connection conn = getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                ingredient = new Ingredient();
                ingredient.setId(rs.getInt("id"));
                ingredient.setName(rs.getString("name"));
                ingredient.setStockQuantity(rs.getFloat("stockQuantity"));
                ingredient.setContent(rs.getString("content"));
                ingredient.setUnitPrice(rs.getFloat("unitPrice"));
                ingredient.setCategory(rs.getString("category"));
            }

            rs.close();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return ingredient;
    }

    /**
     * Add new ingredient
     */
    public boolean addNewIngredient(Ingredient ingredient) {
        String sql = "INSERT INTO Ingredient (name, stockQuantity, content, unitPrice, category) VALUES (?, ?, ?, ?, ?)";

        try {
            Connection conn = getConnection();
            PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, ingredient.getName());
            ps.setFloat(2, ingredient.getStockQuantity());
            ps.setString(3, ingredient.getContent());
            ps.setFloat(4, ingredient.getUnitPrice());
            ps.setString(5, ingredient.getCategory());

            int affectedRows = ps.executeUpdate();

            if (affectedRows > 0) {
                ResultSet generatedKeys = ps.getGeneratedKeys();
                if (generatedKeys.next()) {
                    ingredient.setId(generatedKeys.getInt(1));
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

    /**
     * Update ingredient stock quantity
     */
    public boolean updateStockQuantity(int ingredientId, float additionalQuantity) {
        String sql = "UPDATE Ingredient SET stockQuantity = stockQuantity + ? WHERE id = ?";

        try {
            Connection conn = getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setFloat(1, additionalQuantity);
            ps.setInt(2, ingredientId);

            int affectedRows = ps.executeUpdate();
            ps.close();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
