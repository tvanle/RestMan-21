package model;

import java.sql.Timestamp;

public class User {
    private int id;
    private String username;
    private String role;
    private String address;
    private Timestamp createdAt;

    public User() {}

    public User(int id, String username, String role, String address, Timestamp createdAt) {
        this.id = id;
        this.username = username;
        this.role = role;
        this.address = address;
        this.createdAt = createdAt;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
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
