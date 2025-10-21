package model;

public class Manager extends User {

    public Manager() {
        super();
    }

    public Manager(int id, String username, String role, String address, java.sql.Timestamp createdAt) {
        super(id, username, role, address, createdAt);
    }
}
