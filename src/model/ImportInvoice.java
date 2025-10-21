package model;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

public class ImportInvoice {
    private int id;
    private Date date;
    private float totalAmount;
    private Supplier supplier;
    private WarehouseStaff warehouseStaff;
    private List<ImportDetail> importDetails;

    public ImportInvoice() {
        this.importDetails = new ArrayList<>();
    }

    public ImportInvoice(int id, Date date, float totalAmount, Supplier supplier, WarehouseStaff warehouseStaff) {
        this.id = id;
        this.date = date;
        this.totalAmount = totalAmount;
        this.supplier = supplier;
        this.warehouseStaff = warehouseStaff;
        this.importDetails = new ArrayList<>();
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public float getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(float totalAmount) {
        this.totalAmount = totalAmount;
    }

    public Supplier getSupplier() {
        return supplier;
    }

    public void setSupplier(Supplier supplier) {
        this.supplier = supplier;
    }

    public WarehouseStaff getWarehouseStaff() {
        return warehouseStaff;
    }

    public void setWarehouseStaff(WarehouseStaff warehouseStaff) {
        this.warehouseStaff = warehouseStaff;
    }

    public List<ImportDetail> getImportDetails() {
        return importDetails;
    }

    public void setImportDetails(List<ImportDetail> importDetails) {
        this.importDetails = importDetails;
    }

    public void addImportDetail(ImportDetail detail) {
        this.importDetails.add(detail);
    }
}
