# 🚀 HƯỚNG DẪN CHẠY RESTMAN TỪ A-Z TRÊN VSCODE

## ✅ BƯỚC 1: CÀI ĐẶT CÔNG CỤ CẦN THIẾT

### 1.1. Cài đặt JDK (Java Development Kit)

**Windows:**
```bash
# Download JDK 8 hoặc 11 từ:
# https://www.oracle.com/java/technologies/downloads/
# hoặc https://adoptium.net/ (OpenJDK - Miễn phí)

# Sau khi cài, kiểm tra:
java -version
javac -version
```

**Thiết lập JAVA_HOME:**
- Windows: System Properties → Environment Variables
- Thêm biến: `JAVA_HOME = C:\Program Files\Java\jdk-11.0.xx`
- Thêm vào Path: `%JAVA_HOME%\bin`

### 1.2. Cài đặt MySQL

**Download:**
- https://dev.mysql.com/downloads/mysql/
- Chọn "MySQL Community Server"

**Cài đặt:**
```bash
# Sau khi cài, kiểm tra:
mysql --version

# Đăng nhập:
mysql -u root -p
```

### 1.3. Cài đặt Apache Tomcat 9

**Download:**
```
https://tomcat.apache.org/download-90.cgi
→ Core → zip (Windows) hoặc tar.gz (Linux/Mac)
```

**Cài đặt:**
```bash
# Giải nén vào thư mục:
# Windows: C:\apache-tomcat-9.0.80
# Linux/Mac: /opt/apache-tomcat-9.0.80

# Kiểm tra:
cd C:\apache-tomcat-9.0.80\bin
catalina.bat version    # Windows
./catalina.sh version   # Linux/Mac
```

### 1.4. Cài đặt Maven (Tùy chọn nhưng khuyến nghị)

**Download:**
```
https://maven.apache.org/download.cgi
```

**Cài đặt:**
```bash
# Giải nén và thêm vào Path
# Kiểm tra:
mvn -version
```

---

## ✅ BƯỚC 2: CÀI ĐẶT VSCODE VÀ EXTENSIONS

### 2.1. Cài VSCode
- Download: https://code.visualstudio.com/

### 2.2. Cài Extensions (Ctrl+Shift+X)

**BẮT BUỘC:**
1. **Extension Pack for Java** (Microsoft)
   - Java Language Support
   - Debugger for Java
   - Maven for Java
   - Project Manager for Java
   - Test Runner for Java

2. **Tomcat for Java** (Wei Shen)

3. **Community Server Connectors** (Red Hat)

**KHUYẾN NGHỊ:**
4. **MySQL** (Weijan Chen)
5. **Auto Rename Tag**
6. **Prettier** - Code formatter

---

## ✅ BƯỚC 3: MỞ PROJECT TRONG VSCODE

### 3.1. Mở Folder

```bash
# Mở VSCode
# File → Open Folder
# Chọn: C:\Users\PC\Documents\PTTK\RestMan
```

### 3.2. Cấu hình Java trong VSCode

**Nhấn Ctrl+Shift+P:**
```
→ Java: Configure Java Runtime
→ Kiểm tra JDK đã được nhận diện
```

---

## ✅ BƯỚC 4: THIẾT LẬP DATABASE

### 4.1. Khởi động MySQL

**Windows:**
```bash
# Start MySQL Service
net start MySQL80

# Hoặc dùng XAMPP/WAMP Control Panel
```

**Linux/Mac:**
```bash
sudo systemctl start mysql
# hoặc
mysql.server start
```

### 4.2. Tạo Database

**Cách 1: Dùng Terminal**
```bash
# Mở terminal trong VSCode (Ctrl+`)
cd database
mysql -u root -p < restman.sql

# Nhập mật khẩu MySQL
```

**Cách 2: Dùng MySQL Workbench**
```
1. Mở MySQL Workbench
2. File → Open SQL Script
3. Chọn file: database/restman.sql
4. Click Execute (⚡ icon)
```

**Cách 3: Dùng command line**
```bash
mysql -u root -p

# Trong MySQL prompt:
source C:/Users/PC/Documents/PTTK/RestMan/database/restman.sql
# hoặc
CREATE DATABASE restman;
USE restman;
# rồi copy-paste nội dung file SQL
```

### 4.3. Kiểm tra Database

```sql
mysql -u root -p

USE restman;
SHOW TABLES;
SELECT * FROM User;
SELECT * FROM Dish;
```

Kết quả phải có:
- 15+ tables
- User có 3 records (admin, nvkho01, nvban01)
- Dish có 4 records (Phở Bò, Bún Chả,...)

---

## ✅ BƯỚC 5: CẤU HÌNH DATABASE CONNECTION

### 5.1. Mở file DAO.java

```
src/dao/DAO.java
```

### 5.2. Sửa thông tin kết nối

```java
private static final String DB_URL = "jdbc:mysql://localhost:3306/restman";
private static final String DB_USER = "root";
private static final String DB_PASSWORD = "YOUR_MYSQL_PASSWORD";
```

**LƯU Ý:** Thay `YOUR_MYSQL_PASSWORD` bằng mật khẩu MySQL của bạn!

---

## ✅ BƯỚC 6: DOWNLOAD MYSQL CONNECTOR

### 6.1. Download MySQL Connector/J

```
https://dev.mysql.com/downloads/connector/j/
→ Select Operating System: Platform Independent
→ Download ZIP Archive
```

### 6.2. Copy JAR file

```bash
# Giải nén file download
# Copy file mysql-connector-java-8.x.xx.jar

# Paste vào:
WebContent/WEB-INF/lib/mysql-connector-java-8.x.xx.jar
```

---

## ✅ BƯỚC 7: CẤU HÌNH TOMCAT TRONG VSCODE

### 7.1. Mở Tomcat Servers Panel

```
View → Command Palette (Ctrl+Shift+P)
→ Tomcat: Add Tomcat Server
→ Browse và chọn thư mục Tomcat: C:\apache-tomcat-9.0.80
```

### 7.2. Kiểm tra Tomcat

Trong sidebar trái, bạn sẽ thấy:
```
TOMCAT SERVERS
└── Tomcat 9.0.80 (Stopped)
```

---

## ✅ BƯỚC 8: BUILD PROJECT

### CÁC 1: Dùng Maven (Khuyến nghị)

```bash
# Mở terminal trong VSCode (Ctrl+`)
mvn clean package

# Kết quả: target/RestMan.war
```

### CÁCH 2: Build Manual (Nếu không có Maven)

```bash
# 1. Tạo thư mục build
mkdir -p build\classes

# 2. Compile Java files
javac -d build\classes -cp "WebContent\WEB-INF\lib\*;C:\apache-tomcat-9.0.80\lib\servlet-api.jar" src\dao\*.java src\model\*.java src\servlet\*.java

# 3. Copy compiled classes
xcopy /s /y build\classes\* WebContent\WEB-INF\classes\
```

---

## ✅ BƯỚC 9: DEPLOY LÊN TOMCAT

### CÁCH 1: Dùng VSCode Extension

1. **Build WAR file** (nếu dùng Maven):
   ```bash
   mvn clean package
   ```

2. **Deploy trong VSCode:**
   ```
   TOMCAT SERVERS panel
   → Right-click Tomcat server
   → Add Package
   → Chọn file: target/RestMan.war
   ```

### CÁCH 2: Copy thủ công

```bash
# Copy WAR file vào webapps
copy target\RestMan.war C:\apache-tomcat-9.0.80\webapps\
```

### CÁCH 3: Deploy thư mục trực tiếp (Development)

```bash
# Tạo symbolic link hoặc copy toàn bộ project
# Windows (Run as Administrator):
mklink /D C:\apache-tomcat-9.0.80\webapps\RestMan "C:\Users\PC\Documents\PTTK\RestMan\WebContent"

# Linux/Mac:
ln -s /path/to/RestMan/WebContent /opt/tomcat/webapps/RestMan
```

---

## ✅ BƯỚC 10: START TOMCAT

### Trong VSCode:

```
TOMCAT SERVERS panel
→ Right-click Tomcat server
→ Start
```

### Hoặc dùng Terminal:

```bash
# Windows:
cd C:\apache-tomcat-9.0.80\bin
catalina.bat run

# Linux/Mac:
cd /opt/tomcat/bin
./catalina.sh run
```

**Chờ log hiển thị:**
```
INFO: Server startup in [xxxx] milliseconds
```

---

## ✅ BƯỚC 11: TRUY CẬP HỆ THỐNG

### 11.1. Mở Browser

```
http://localhost:8080/RestMan/
```

### 11.2. Test các chức năng

**1. Trang chủ:**
- Click "Khách hàng" → Trang customer

**2. Tìm kiếm món ăn:**
- Click "Tìm kiếm món ăn"
- Nhập "Phở" → Click Tìm kiếm
- Kết quả: Hiển thị Phở Bò
- Click vào món → Xem chi tiết

**3. Đăng nhập Nhân viên kho:**
```
Click "Đăng nhập - Nhân viên"
Username: nvkho01
Password: (để trống hoặc bất kỳ)
Click "Đăng nhập - Nhân viên kho"
```

**4. Nhập nguyên liệu:**
```
Click "Nhập nguyên liệu"
Nhập tên NCC: "Thực phẩm"
Chọn một NCC
Nhập tên nguyên liệu: "Bánh"
Chọn "Bánh Phở"
Nhập số lượng: 5
Đơn giá: 25000
Click "+" để thêm
Click "Xác nhận và thanh toán"
→ Xem hóa đơn
```

---

## ✅ BƯỚC 12: DEBUGGING (Nếu có lỗi)

### 12.1. Xem Tomcat Logs

```bash
# Windows:
type C:\apache-tomcat-9.0.80\logs\catalina.out

# Linux/Mac:
tail -f /opt/tomcat/logs/catalina.out
```

### 12.2. Common Errors

**Error: "Cannot connect to database"**
```bash
# Kiểm tra:
1. MySQL đang chạy: net start MySQL80
2. Database tồn tại: mysql -u root -p → SHOW DATABASES;
3. Username/password đúng trong DAO.java
4. MySQL Connector JAR trong WEB-INF/lib/
```

**Error: "404 Not Found"**
```bash
# Kiểm tra:
1. WAR file đã deploy: ls webapps/RestMan.war
2. URL đúng: http://localhost:8080/RestMan/ (có chữ R viết hoa)
3. Tomcat đang chạy
```

**Error: "500 Internal Server Error"**
```bash
# Xem log trong Tomcat để biết chi tiết
# Thường do:
1. Lỗi SQL syntax
2. Thiếu dependency
3. Code Java có bug
```

**Error: "Port 8080 already in use"**
```bash
# Windows:
netstat -ano | findstr :8080
taskkill /PID <PID> /F

# Linux/Mac:
lsof -ti:8080 | xargs kill -9
```

---

## ✅ BƯỚC 13: HOT RELOAD (Không cần restart)

### 13.1. Cài Extension

```
Live Server (Ritwick Dey)
```

### 13.2. Enable Auto Deploy

**Trong VSCode:**
```
Settings → Tomcat → Auto Reload: true
```

**Trong Tomcat server.xml:**
```xml
<Context reloadable="true" />
```

**Khi sửa code:**
- **JSP files**: Save → tự reload
- **Java files**: Rebuild → restart Tomcat

---

## ✅ CHECKLIST HOÀN THÀNH

- [ ] JDK 8+ đã cài và cấu hình JAVA_HOME
- [ ] MySQL đã cài và đang chạy
- [ ] Tomcat 9 đã download và giải nén
- [ ] VSCode đã cài Extensions: Java Pack, Tomcat for Java
- [ ] Database `restman` đã tạo và có dữ liệu
- [ ] File DAO.java đã cấu hình đúng password
- [ ] mysql-connector-java.jar đã copy vào WEB-INF/lib/
- [ ] Tomcat đã cấu hình trong VSCode
- [ ] Project đã build thành công (có file .war hoặc .class)
- [ ] Deploy lên Tomcat thành công
- [ ] Tomcat đã start không lỗi
- [ ] Truy cập http://localhost:8080/RestMan/ thành công
- [ ] Test tìm kiếm món ăn OK
- [ ] Test nhập nguyên liệu OK

---

## 📞 SUPPORT

Nếu gặp vấn đề, kiểm tra theo thứ tự:

1. **Java**: `java -version` → Phải có output
2. **MySQL**: `mysql -u root -p` → Đăng nhập được
3. **Database**: `USE restman; SHOW TABLES;` → Có 15+ tables
4. **Tomcat**: `http://localhost:8080` → Thấy trang Tomcat
5. **WAR deployed**: Kiểm tra thư mục `webapps/RestMan/`
6. **Logs**: Xem file `logs/catalina.out` để debug

---

## 🎉 KẾT QUẢ

Nếu mọi thứ OK, bạn sẽ thấy:

```
✅ Trang chủ hiển thị logo RestMan
✅ Module Khách hàng: Tìm kiếm món ăn hoạt động
✅ Module Nhân viên kho: Nhập nguyên liệu hoạt động
✅ Hóa đơn hiển thị và in được
```

**Screenshot mẫu:**
- Trang chủ: Có 2 nút (Khách hàng, Đăng nhập)
- Tìm kiếm: Nhập "Phở" → Thấy "Phở Bò 45,000đ"
- Chi tiết món: Có ảnh, giá, mô tả, nguyên liệu
- Nhập NL: Chọn NCC → Chọn NL → Tạo hóa đơn

---

Chúc bạn thành công! 🚀
