package model;

public class WarehouseStaff extends User {

    public WarehouseStaff() {
        super();
    }

    public WarehouseStaff(int id, String username, String role, String address, java.sql.Timestamp createdAt) {
        super(id, username, role, address, createdAt);
    }
}
