-- RestMan Database Schema
-- Restaurant Management System

CREATE DATABASE IF NOT EXISTS restman CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE restman;

-- User table (base table for all user types)
CREATE TABLE User (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255),
    role VARCHAR(20) NOT NULL,
    address VARCHAR(255),
    email VARCHAR(100),
    phone VARCHAR(20),
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Manager table
CREATE TABLE Manager (
    id INT PRIMARY KEY,
    FOREIGN KEY (id) REFERENCES User(id) ON DELETE CASCADE
);

-- WarehouseStaff table
CREATE TABLE WarehouseStaff (
    id INT PRIMARY KEY,
    FOREIGN KEY (id) REFERENCES User(id) ON DELETE CASCADE
);

-- SaleStaff table
CREATE TABLE SaleStaff (
    id INT PRIMARY KEY,
    FOREIGN KEY (id) REFERENCES User(id) ON DELETE CASCADE
);

-- Customer table
CREATE TABLE Customer (
    userid_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    address VARCHAR(255),
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- MemberCard table
CREATE TABLE MemberCard (
    id INT AUTO_INCREMENT PRIMARY KEY,
    number VARCHAR(50) UNIQUE NOT NULL,
    issueDate DATE,
    expireDate DATE,
    customerUserId INT,
    FOREIGN KEY (customerUserId) REFERENCES Customer(userid_id) ON DELETE SET NULL
);

-- Table
CREATE TABLE `Table` (
    id INT AUTO_INCREMENT PRIMARY KEY,
    number INT NOT NULL,
    capacity INT,
    status VARCHAR(50) DEFAULT 'available'
);

-- TableRevers
CREATE TABLE TableRevers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer INT,
    date DATE,
    time TIME,
    numberPeople INT,
    FOREIGN KEY (customer) REFERENCES Customer(userid_id) ON DELETE SET NULL
);

-- Dish
CREATE TABLE Dish (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(11,2) NOT NULL,
    description TEXT,
    category VARCHAR(50),
    chef_id INT
);

-- ComboMenu
CREATE TABLE ComboMenu (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(11,2) NOT NULL,
    description TEXT
);

-- ComboItem
CREATE TABLE ComboItem (
    id INT AUTO_INCREMENT PRIMARY KEY,
    combo_id INT NOT NULL,
    name VARCHAR(100),
    quantity INT DEFAULT 1,
    note TEXT,
    FOREIGN KEY (combo_id) REFERENCES ComboMenu(id) ON DELETE CASCADE
);

-- Order
CREATE TABLE `Order` (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer INT,
    saleStaff_userid_id INT,
    date DATE,
    status VARCHAR(50) DEFAULT 'pending',
    FOREIGN KEY (customer) REFERENCES Customer(userid_id) ON DELETE SET NULL,
    FOREIGN KEY (saleStaff_userid_id) REFERENCES SaleStaff(id) ON DELETE SET NULL
);

-- DishOrder
CREATE TABLE DishOrder (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    dish_id INT NOT NULL,
    quantity INT DEFAULT 1,
    note TEXT,
    FOREIGN KEY (order_id) REFERENCES `Order`(id) ON DELETE CASCADE,
    FOREIGN KEY (dish_id) REFERENCES Dish(id) ON DELETE CASCADE
);

-- Invoice
CREATE TABLE Invoice (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT UNIQUE,
    total DECIMAL(11,2),
    customerAmount DECIMAL(11,2),
    FOREIGN KEY (order_id) REFERENCES `Order`(id) ON DELETE SET NULL
);

-- Supplier
CREATE TABLE Supplier (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    address VARCHAR(255)
);

-- Ingredient
CREATE TABLE Ingredient (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    stockQuantity FLOAT DEFAULT 0,
    content VARCHAR(100),
    unitPrice DECIMAL(11,2),
    category VARCHAR(50)
);

-- ImportInvoice
CREATE TABLE ImportInvoice (
    id INT AUTO_INCREMENT PRIMARY KEY,
    date DATE,
    totalAmount FLOAT,
    supplier_id INT,
    warehouseStaff_userid_id INT,
    FOREIGN KEY (supplier_id) REFERENCES Supplier(id) ON DELETE SET NULL,
    FOREIGN KEY (warehouseStaff_userid_id) REFERENCES WarehouseStaff(id) ON DELETE SET NULL
);

-- ImportDetail
CREATE TABLE ImportDetail (
    id INT AUTO_INCREMENT PRIMARY KEY,
    importInvoice_id INT NOT NULL,
    ingredient_id INT,
    quantity FLOAT,
    unitPrice DECIMAL(11,2),
    FOREIGN KEY (importInvoice_id) REFERENCES ImportInvoice(id) ON DELETE CASCADE,
    FOREIGN KEY (ingredient_id) REFERENCES Ingredient(id) ON DELETE SET NULL
);

-- Insert sample data for testing

-- Users (password: 123456 for all sample accounts)
INSERT INTO User (username, password, role, address, email, phone) VALUES
('admin', '123456', 'MANAGER', 'Hà Nội', 'admin@restman.vn', '0901234567'),
('nvkho01', '123456', 'WAREHOUSE_STAFF', 'Hà Nội', 'warehouse@restman.vn', '0901234568'),
('nvban01', '123456', 'SALE_STAFF', 'Hà Nội', 'sales@restman.vn', '0901234569'),
('customer01', '123456', 'CUSTOMER', 'Hà Nội', 'customer1@gmail.com', '0912345678'),
('customer02', '123456', 'CUSTOMER', 'Hồ Chí Minh', 'customer2@gmail.com', '0923456789');

-- Manager
INSERT INTO Manager (id) VALUES (1);

-- WarehouseStaff
INSERT INTO WarehouseStaff (id) VALUES (2);

-- SaleStaff
INSERT INTO SaleStaff (id) VALUES (3);

-- Customers
INSERT INTO Customer (name, phone, address) VALUES
('Nguyễn Văn A', '0123456789', 'Hà Nội'),
('Trần Thị B', '0987654321', 'Hồ Chí Minh');

-- Suppliers
INSERT INTO Supplier (name, phone, address) VALUES
('Công ty TNHH Thực phẩm Sạch', '0123456789', 'Hà Nội'),
('NCC Rau Củ Quả Đà Lạt', '0987654321', 'Đà Lạt'),
('Thực phẩm Tươi Sống', '0369852147', 'TP.HCM');

-- Ingredients
INSERT INTO Ingredient (name, stockQuantity, content, unitPrice, category) VALUES
('Bánh Phở', 50.0, 'kg', 25000, 'Bột'),
('Thịt Bò', 30.0, 'kg', 200000, 'Thịt'),
('Hành', 10.0, 'kg', 15000, 'Rau củ'),
('Ngò', 5.0, 'kg', 20000, 'Rau thơm');

-- Dishes
INSERT INTO Dish (name, price, description, category) VALUES
('Phở Bò', 45000, 'Phở bò truyền thống Hà Nội với nước dùng đậm đà', 'Món chính'),
('Bún Chả', 50000, 'Bún chả Hà Nội đặc trưng', 'Món chính'),
('Gỏi Cuốn', 30000, 'Gỏi cuốn tôm thịt tươi ngon', 'Khai vị'),
('Chả Giò', 35000, 'Chả giò chiên giòn rụm', 'Khai vị');

-- ComboMenu
INSERT INTO ComboMenu (name, price, description) VALUES
('Combo Gia Đình', 200000, 'Phở bò + Bún chả + 2 Gỏi cuốn'),
('Combo Tiết Kiệm', 120000, 'Phở bò + Chả giò + Nước ngọt');

-- Tables
INSERT INTO `Table` (number, capacity, status) VALUES
(1, 4, 'available'),
(2, 4, 'available'),
(3, 6, 'available'),
(4, 2, 'available'),
(5, 8, 'available');
