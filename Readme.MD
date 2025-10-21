# 🍴 RestMan - Hệ thống Quản lý Nhà hàng

**Đề số 21**: Lê Văn Trọng
**Môn học**: Phân tích Thiết kế Hệ thống Thông tin
**Năm**: 2025

## 📖 Giới thiệu

RestMan là hệ thống quản lý nhà hàng cho phép nhân viên quản lý, nhân viên bán hàng và khách hàng sử dụng. Hệ thống bao gồm các chức năng chính:

### 🎯 Chức năng chính

- **Nhân viên quản lý**: Xem thống kê món ăn, nguyên liệu, khách hàng, nhà cung cấp. Quản lý thông tin món ăn, lên menu combo
- **Nhân viên kho**: Nhập nguyên liệu từ nhà cung cấp, quản lý thông tin nhà cung cấp
- **Nhân viên bán hàng**: Nhận khách, gọi món, thanh toán, làm thẻ thành viên, xác nhận đặt bàn/đặt món
- **Khách hàng**: Tìm kiếm món ăn, đặt bàn và đặt món trực tuyến

### ✅ Modules đã triển khai

1. **Module Tìm kiếm món ăn** (Khách hàng) - ✅ Hoàn thành
2. **Module Nhập nguyên liệu** (Nhân viên kho) - ✅ Hoàn thành

## 🛠️ Công nghệ sử dụng

- **Ngôn ngữ lập trình:** Java 8+
- **Web Technologies:** JSP, Servlets
- **Database:** MySQL 8.0
- **Database Connectivity:** JDBC
- **Web Server:** Apache Tomcat 9
- **IDE:** VSCode / Eclipse / IntelliJ IDEA
- **Build Tool:** Maven (optional)

## 🚀 CHẠY NHANH (5 PHÚT)

### Cách 1: Dùng Scripts tự động (Windows)

```bash
# 1. Setup môi trường
setup.bat

# 2. Build project
build.bat

# 3. Chạy Tomcat
run.bat

# 4. Mở browser
http://localhost:8080/RestMan/
```

### Cách 2: Manual

Xem hướng dẫn chi tiết trong [INSTALL.md](INSTALL.md) hoặc [QUICKSTART.md](QUICKSTART.md)

## 📁 Cấu trúc Project

```
RestMan/
├── src/                          # Source code Java
│   ├── dao/                      # Data Access Objects
│   │   ├── DAO.java             # Base DAO, quản lý connection
│   │   ├── DishDAO.java
│   │   ├── SupplierDAO.java
│   │   ├── IngredientDAO.java
│   │   ├── ImportInvoiceDAO.java
│   │   ├── ImportDetailDAO.java
│   │   └── UserDAO.java
│   ├── model/                    # Entity classes
│   │   ├── User.java
│   │   ├── Dish.java
│   │   ├── Supplier.java
│   │   ├── Ingredient.java
│   │   ├── ImportInvoice.java
│   │   └── ImportDetail.java
│   └── servlet/                  # Servlets
│       ├── LoginServlet.java
│       ├── SearchDishServlet.java
│       ├── SupplierServlet.java
│       ├── IngredientServlet.java
│       └── ImportInvoiceServlet.java
├── WebContent/                   # Web resources
│   ├── WEB-INF/
│   │   ├── lib/                 # Libraries
│   │   │   └── mysql-connector-java-8.x.jar ⚠️ PHẢI CÓ
│   │   └── web.xml              # Web config
│   ├── css/
│   │   └── style.css            # Stylesheet
│   ├── customer/                # Customer pages
│   │   ├── Customer.jsp
│   │   ├── SearchDish.jsp
│   │   └── DishDetail.jsp
│   ├── warehousestaff/          # Warehouse staff pages
│   │   ├── WarehouseStaff.jsp
│   │   ├── SearchSupplier.jsp
│   │   ├── ImportInvoice.jsp
│   │   └── InvoiceSuccess.jsp
│   ├── Login.jsp
│   └── index.jsp
├── database/
│   └── restman.sql              # Database script
├── target/                       # Build output
│   └── RestMan.war              # Deployable WAR file
├── .vscode/                      # VSCode config
├── pom.xml                       # Maven config
├── setup.bat                     # 🚀 Auto setup
├── build.bat                     # 🔨 Build script
├── run.bat                       # ▶️ Run script
├── INSTALL.md                    # 📖 Detailed guide
├── QUICKSTART.md                 # ⚡ Quick start
└── README.md                     # This file
```