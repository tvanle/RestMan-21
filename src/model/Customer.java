package model;

import java.sql.Timestamp;

public class Customer {
    private int useridId;
    private String name;
    private String phone;
    private String address;
    private Timestamp createdAt;

    public Customer() {}

    public Customer(int useridId, String name, String phone, String address, Timestamp createdAt) {
        this.useridId = useridId;
        this.name = name;
        this.phone = phone;
        this.address = address;
        this.createdAt = createdAt;
    }

    // Getters and Setters
    public int getUseridId() {
        return useridId;
    }

    public void setUseridId(int useridId) {
        this.useridId = useridId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}
