package model;

public class SaleStaff extends User {

    public SaleStaff() {
        super();
    }

    public SaleStaff(int id, String username, String role, String address, java.sql.Timestamp createdAt) {
        super(id, username, role, address, createdAt);
    }
}
