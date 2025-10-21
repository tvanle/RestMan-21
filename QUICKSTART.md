# ⚡ QUICKSTART - Chạy ngay trong 5 phút

## ✅ CHUẨN BỊ TRƯỚC

1. **Cài JDK**: https://adoptium.net/ (JDK 11)
2. **Cài MySQL**: https://dev.mysql.com/downloads/mysql/
3. **Download Tomcat 9**: https://tomcat.apache.org/download-90.cgi (ZIP)
4. **Cài VSCode**: https://code.visualstudio.com/

## 🚀 CHẠY NHANH (Windows)

### Bước 1: Chạy script tự động

```cmd
cd C:\Users\PC\Documents\PTTK\RestMan
setup.bat
```

Script sẽ:
- ✅ Kiểm tra Java, MySQL, Maven
- ✅ Tạo thư mục cần thiết
- ✅ Hướng dẫn setup database
- ✅ Cấu hình database connection

### Bước 2: Setup Database

**Cách nhanh nhất:**
```cmd
mysql -u root -p < database\restman.sql
```

Nhập password MySQL và Enter.

### Bước 3: Download MySQL Connector

```
1. Vào: https://dev.mysql.com/downloads/connector/j/
2. Download "Platform Independent" ZIP
3. Giải nén, copy file mysql-connector-java-8.x.xx.jar
4. Paste vào: WebContent\WEB-INF\lib\
```

### Bước 4: Build Project

```cmd
build.bat
```

### Bước 5: Mở VSCode

```cmd
code .
```

**Cài Extensions (Ctrl+Shift+X):**
- Extension Pack for Java
- Tomcat for Java

**Cấu hình Tomcat:**
```
Ctrl+Shift+P → Tomcat: Add Tomcat Server
→ Chọn thư mục Tomcat (C:\apache-tomcat-9.0.80)
```

### Bước 6: Deploy và Chạy

**Cách 1: Dùng script**
```cmd
run.bat
```

**Cách 2: Trong VSCode**
```
TOMCAT SERVERS panel (sidebar)
→ Right-click server → Add Package → target\RestMan.war
→ Right-click server → Start
```

### Bước 7: Truy cập

```
http://localhost:8080/RestMan/
```

## 🎯 TEST NHANH

### Test 1: Tìm kiếm món ăn
```
1. Click "Khách hàng"
2. Click "Tìm kiếm món ăn"
3. Nhập "Phở" → Tìm kiếm
4. Click "Phở Bò" → Xem chi tiết
✅ PASS nếu thấy thông tin món ăn
```

### Test 2: Nhập nguyên liệu
```
1. Back to Home → "Đăng nhập - Nhân viên"
2. Username: nvkho01
3. Click "Đăng nhập - Nhân viên kho"
4. Click "Nhập nguyên liệu"
5. Nhập "Thực phẩm" → Tìm → Chọn NCC
6. Nhập "Bánh" → Tìm → Chọn "Bánh Phở"
7. SL: 5, Giá: 25000 → Click "+"
8. Click "Xác nhận và thanh toán"
✅ PASS nếu thấy hóa đơn
```

## 🐛 TROUBLESHOOTING

### Lỗi 1: "Cannot connect to database"
```cmd
# Kiểm tra MySQL đang chạy
net start MySQL80

# Kiểm tra password trong src\dao\DAO.java
```

### Lỗi 2: "404 Not Found"
```
- Check URL: http://localhost:8080/RestMan/ (chữ R hoa)
- Kiểm tra WAR deployed: dir %TOMCAT%\webapps\RestMan.war
```

### Lỗi 3: "Port 8080 in use"
```cmd
netstat -ano | findstr :8080
taskkill /PID <PID> /F
```

### Lỗi 4: Compilation failed
```
- Kiểm tra JAVA_HOME: echo %JAVA_HOME%
- Kiểm tra servlet-api.jar trong Tomcat
```

## 📁 CẤU TRÚC SAU KHI SETUP

```
RestMan/
├── src/               ✅ Source code
├── WebContent/        ✅ Web files
│   └── WEB-INF/lib/
│       └── mysql-connector-java-8.x.jar  ✅ PHẢI CÓ
├── database/
│   └── restman.sql    ✅ Database script
├── target/
│   └── RestMan.war    ✅ Deployable file (sau build)
├── build/
│   └── classes/       ✅ Compiled Java files
├── setup.bat          ✅ Auto setup
├── build.bat          ✅ Build script
└── run.bat            ✅ Run script
```

## 🎓 TÀI KHOẢN TEST

```
Nhân viên kho:
- Username: nvkho01
- Password: (bất kỳ hoặc để trống)

Manager:
- Username: admin
- Password: (bất kỳ)
```

## 📚 CHI TIẾT HƠN

Xem file [INSTALL.md](INSTALL.md) để biết hướng dẫn chi tiết từng bước.

---

**Tổng thời gian:** 5-10 phút (nếu đã cài đủ công cụ)

Chúc bạn thành công! 🚀
