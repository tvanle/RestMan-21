package model;

public class ImportDetail {
    private int id;
    private int importInvoiceId;
    private Ingredient ingredient;
    private float quantity;
    private float unitPrice;

    public ImportDetail() {}

    public ImportDetail(int id, int importInvoiceId, Ingredient ingredient, float quantity, float unitPrice) {
        this.id = id;
        this.importInvoiceId = importInvoiceId;
        this.ingredient = ingredient;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getImportInvoiceId() {
        return importInvoiceId;
    }

    public void setImportInvoiceId(int importInvoiceId) {
        this.importInvoiceId = importInvoiceId;
    }

    public Ingredient getIngredient() {
        return ingredient;
    }

    public void setIngredient(Ingredient ingredient) {
        this.ingredient = ingredient;
    }

    public float getQuantity() {
        return quantity;
    }

    public void setQuantity(float quantity) {
        this.quantity = quantity;
    }

    public float getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(float unitPrice) {
        this.unitPrice = unitPrice;
    }

    public float getTotalPrice() {
        return quantity * unitPrice;
    }
}
