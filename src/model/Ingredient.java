package model;

public class Ingredient {
    private int id;
    private String name;
    private float stockQuantity;
    private String content;
    private float unitPrice;
    private String category;

    public Ingredient() {}

    public Ingredient(int id, String name, float stockQuantity, String content, float unitPrice, String category) {
        this.id = id;
        this.name = name;
        this.stockQuantity = stockQuantity;
        this.content = content;
        this.unitPrice = unitPrice;
        this.category = category;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public float getStockQuantity() {
        return stockQuantity;
    }

    public void setStockQuantity(float stockQuantity) {
        this.stockQuantity = stockQuantity;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public float getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(float unitPrice) {
        this.unitPrice = unitPrice;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }
}
