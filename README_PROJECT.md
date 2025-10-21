# RestMan - Hệ thống Quản lý Nhà hàng

**Đề số 21**: Lê Văn Trọng

## Giới thiệu

RestMan là hệ thống quản lý nhà hàng được phát triển cho môn học **Phân tích Thiết kế Hệ thống Thông tin**. Hệ thống hỗ trợ các chức năng cho:
- Khách hàng: Tìm kiếm món ăn, đặt bàn, đặt món trực tuyến
- Nhân viên kho: Nhập nguyên liệu từ nhà cung cấp, quản lý nhà cung cấp
- Nhân viên bán hàng: Nhận khách, gọi món, thanh toán
- Quản lý: Xem thống kê, quản lý món ăn, tạo menu combo

## Công nghệ sử dụng

- **Ngôn ngữ lập trình:** Java
- **Web Technologies:** JSP, Servlets
- **Database:** MySQL
- **Database Connectivity:** JDBC
- **Web Server:** Apache Tomcat 9
- **IDE:** Eclipse / IntelliJ IDEA

## Cấu trúc dự án

```
RestMan/
├── database/
│   └── restman.sql              # Script tạo CSDL
├── src/
│   ├── dao/                     # Data Access Objects
│   │   ├── DAO.java            # Base DAO class
│   │   ├── DishDAO.java
│   │   ├── SupplierDAO.java
│   │   ├── IngredientDAO.java
│   │   ├── ImportInvoiceDAO.java
│   │   ├── ImportDetailDAO.java
│   │   └── UserDAO.java
│   ├── model/                   # Entity classes
│   │   ├── User.java
│   │   ├── Manager.java
│   │   ├── WarehouseStaff.java
│   │   ├── SaleStaff.java
│   │   ├── Customer.java
│   │   ├── Dish.java
│   │   ├── Supplier.java
│   │   ├── Ingredient.java
│   │   ├── ImportInvoice.java
│   │   └── ImportDetail.java
│   └── servlet/                 # Servlets
│       ├── LoginServlet.java
│       ├── SearchDishServlet.java
│       ├── SupplierServlet.java
│       ├── IngredientServlet.java
│       └── ImportInvoiceServlet.java
├── WebContent/
│   ├── WEB-INF/
│   │   ├── web.xml             # Deployment descriptor
│   │   └── lib/                # Libraries (MySQL Connector)
│   ├── css/
│   │   └── style.css           # Stylesheet
│   ├── customer/               # Customer JSP pages
│   │   ├── Customer.jsp
│   │   ├── SearchDish.jsp
│   │   └── DishDetail.jsp
│   ├── warehousestaff/         # Warehouse Staff JSP pages
│   │   ├── WarehouseStaff.jsp
│   │   ├── SearchSupplier.jsp
│   │   ├── ImportInvoice.jsp
│   │   └── InvoiceSuccess.jsp
│   ├── Login.jsp               # Login page
│   └── index.jsp               # Home page
└── README_PROJECT.md
```

## Modules đã triển khai

### Module 1: Tìm kiếm thông tin món ăn (Khách hàng)

**Luồng hoạt động:**
1. Khách hàng truy cập trang chủ → Chọn "Tìm kiếm món ăn"
2. Nhập tên món ăn → Hệ thống hiển thị danh sách món ăn
3. Click vào món ăn → Xem chi tiết (tên, giá, mô tả, nguyên liệu)

**Files liên quan:**
- `Customer.jsp` - Trang chủ khách hàng
- `SearchDish.jsp` - Trang tìm kiếm
- `DishDetail.jsp` - Chi tiết món ăn
- `SearchDishServlet.java` - Xử lý logic tìm kiếm
- `DishDAO.java` - Truy vấn CSDL món ăn

### Module 2: Nhập nguyên liệu từ nhà cung cấp (Nhân viên kho)

**Luồng hoạt động:**
1. Đăng nhập với role "Nhân viên kho"
2. Chọn "Nhập nguyên liệu"
3. **Bước 1**: Tìm và chọn nhà cung cấp (có thể thêm mới)
4. **Bước 2**: Tìm và chọn nguyên liệu (có thể thêm mới)
   - Nhập số lượng và đơn giá
   - Thêm vào danh sách nhập
   - Lặp lại cho đến khi nhập đủ nguyên liệu
5. Xác nhận → Hệ thống tạo hóa đơn nhập, cập nhật tồn kho
6. In hóa đơn và thanh toán

**Files liên quan:**
- `Login.jsp` - Đăng nhập
- `WarehouseStaff.jsp` - Trang chủ nhân viên kho
- `SearchSupplier.jsp` - Tìm nhà cung cấp
- `ImportInvoice.jsp` - Chọn nguyên liệu và tạo hóa đơn
- `InvoiceSuccess.jsp` - Hiển thị hóa đơn hoàn thành
- `SupplierServlet.java` - Xử lý nhà cung cấp
- `IngredientServlet.java` - Xử lý nguyên liệu
- `ImportInvoiceServlet.java` - Xử lý lưu hóa đơn
- `SupplierDAO.java`, `IngredientDAO.java`, `ImportInvoiceDAO.java`, `ImportDetailDAO.java`

## Hướng dẫn cài đặt

### 1. Cài đặt môi trường

- **JDK 8** trở lên
- **Apache Tomcat 9**
- **MySQL Server 8.0**
- **Eclipse IDE** hoặc **IntelliJ IDEA**
- **MySQL Connector/J** (JDBC Driver)

### 2. Thiết lập Database

```bash
# 1. Đăng nhập MySQL
mysql -u root -p

# 2. Chạy script tạo database
source database/restman.sql

# Hoặc import từ MySQL Workbench
```

### 3. Cấu hình Database Connection

Mở file `src/dao/DAO.java` và cập nhật thông tin kết nối:

```java
private static final String DB_URL = "jdbc:mysql://localhost:3306/restman";
private static final String DB_USER = "root";
private static final String DB_PASSWORD = "your_password";
```

### 4. Thêm MySQL Connector vào project

- Download `mysql-connector-java-8.x.x.jar`
- Copy vào thư mục `WebContent/WEB-INF/lib/`

### 5. Deploy trên Tomcat

**Với Eclipse:**
1. Right-click project → Run As → Run on Server
2. Chọn Tomcat 9
3. Click Finish

**Với IntelliJ IDEA:**
1. Add Configuration → Tomcat Server → Local
2. Deployment tab → Add → Artifact
3. Run

### 6. Truy cập hệ thống

```
http://localhost:8080/RestMan/
```

## Tài khoản test

```
Nhân viên kho:
- Username: nvkho01
- Role: WAREHOUSE_STAFF

Manager:
- Username: admin
- Role: MANAGER
```

## Tính năng chính

### ✅ Đã hoàn thành

- [x] Module tìm kiếm món ăn
- [x] Module nhập nguyên liệu từ nhà cung cấp
- [x] Giao diện responsive, thân thiện
- [x] Hệ thống đăng nhập phân quyền
- [x] Quản lý session
- [x] In hóa đơn nhập hàng
- [x] Tự động cập nhật tồn kho

### 🚧 Có thể mở rộng

- [ ] Module đặt bàn trực tuyến
- [ ] Module đặt món trực tuyến
- [ ] Module nhận khách và gọi món (Sale Staff)
- [ ] Module thanh toán tại bàn
- [ ] Module làm thẻ thành viên
- [ ] Module thống kê (Manager)
- [ ] Module quản lý món ăn và combo

## Kiến trúc hệ thống

### Design Patterns sử dụng

1. **MVC (Model-View-Controller)**
   - Model: Entity classes trong package `model`
   - View: JSP files
   - Controller: Servlet classes

2. **DAO Pattern**
   - Tách biệt logic truy cập database
   - Base class `DAO` quản lý connection
   - Các DAO cụ thể kế thừa từ base class

3. **Singleton Pattern**
   - Connection pool trong DAO class

### Database Schema

Hệ thống sử dụng 15+ tables:
- User, Manager, WarehouseStaff, SaleStaff
- Customer, MemberCard
- Dish, ComboMenu, ComboItem
- Supplier, Ingredient
- ImportInvoice, ImportDetail
- Order, DishOrder, Invoice, Table, TableRevers

Chi tiết xem file `database/restman.sql`

## UML Diagrams

### Class Diagram
- Module 1: [Customer] - [SearchDishServlet] - [DishDAO] - [Dish]
- Module 2: [WarehouseStaff] - [Servlets] - [DAOs] - [Models]

### Sequence Diagram
Chi tiết trong file `21B22DCCN863-Designfull.pdf` trang 9-13

### Activity Diagram
Chi tiết trong file `21B22DCCN863-Designfull.pdf` trang 8-9

## Testing

### Manual Testing

**Test Case 1: Tìm kiếm món ăn**
```
1. Truy cập trang chủ
2. Click "Tìm kiếm món ăn"
3. Nhập "Phở" → Submit
4. Kết quả: Hiển thị "Phở Bò"
5. Click "Phở Bò"
6. Kết quả: Hiển thị chi tiết món
```

**Test Case 2: Nhập nguyên liệu**
```
1. Đăng nhập với nvkho01
2. Click "Nhập nguyên liệu"
3. Tìm NCC "Thực phẩm"
4. Chọn NCC
5. Tìm nguyên liệu "Bánh"
6. Chọn "Bánh Phở", nhập SL: 2, giá: 25000
7. Click Thêm
8. Xác nhận và thanh toán
9. Kết quả: Hiển thị hóa đơn, tồn kho tăng
```

## Troubleshooting

### Lỗi Connection refused
```
- Kiểm tra MySQL đang chạy
- Kiểm tra port 3306
- Kiểm tra username/password trong DAO.java
```

### Lỗi ClassNotFoundException: com.mysql.cj.jdbc.Driver
```
- Thêm mysql-connector-java.jar vào WEB-INF/lib
- Rebuild project
```

### Lỗi 404 khi truy cập JSP
```
- Kiểm tra context path
- Kiểm tra file web.xml
- Restart Tomcat
```

## Tác giả

- **Sinh viên:** Lê Văn Trọng
- **MSSV:** 21B22DCCN863
- **Lớp:** Phân tích Thiết kế Hệ thống Thông tin
- **Năm:** 2025

## License

Dự án học tập - Không sử dụng cho mục đích thương mại

---

**Ghi chú:** Đây là project mẫu cho môn học. Code có thể được cải thiện thêm về:
- Error handling
- Input validation
- Security (password hashing, SQL injection prevention)
- Performance optimization
- Unit testing
