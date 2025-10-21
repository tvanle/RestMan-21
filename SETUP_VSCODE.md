# Hướng dẫn chạy RestMan trên VSCode

## Bước 1: Cài đặt Extensions cho VSCode

Mở VSCode và cài đặt các extensions sau (Ctrl+Shift+X):

### Bắt buộc:
1. **Extension Pack for Java** (Microsoft)
   - Bao gồm: Language Support, Debugger, Test Runner, Maven, Project Manager
2. **Tomcat for Java** (Wei Shen)
3. **Community Server Connectors** (Red Hat)

### Khuyên dùng:
4. **MySQL** (Weijan Chen)
5. **Better Comments**

## Bước 2: Cài đặt JDK

```bash
# Kiểm tra Java đã cài chưa
java -version

# Nếu chưa có, download JDK 8 hoặc 11 từ:
# https://www.oracle.com/java/technologies/downloads/
# hoặc https://adoptium.net/
```

Sau khi cài, thiết lập biến môi trường `JAVA_HOME`

## Bước 3: Cài đặt Apache Tomcat

### Download Tomcat:
1. Tải Tomcat 9: https://tomcat.apache.org/download-90.cgi
2. Chọn "Core" → "zip" (Windows) hoặc "tar.gz" (Linux/Mac)
3. Giải nén vào thư mục (ví dụ: `C:\apache-tomcat-9.0.xx`)

### Cấu hình Tomcat trong VSCode:

1. Nhấn `Ctrl+Shift+P` → gõ "Tomcat: Add Tomcat Server"
2. Chọn thư mục đã giải nén Tomcat
3. Hoặc tạo file `.vscode/settings.json`:

```json
{
    "tomcatForJava.tomcatInstallations": [
        {
            "name": "Tomcat 9",
            "path": "C:\\apache-tomcat-9.0.xx",
            "version": "9.0.xx"
        }
    ]
}
```

## Bước 4: Setup MySQL Database

```bash
# 1. Đăng nhập MySQL
mysql -u root -p

# 2. Tạo database
source database/restman.sql

# Hoặc
mysql -u root -p < database/restman.sql
```

## Bước 5: Cấu hình Database Connection

Mở file `src/dao/DAO.java` và sửa:

```java
private static final String DB_URL = "jdbc:mysql://localhost:3306/restman";
private static final String DB_USER = "root";
private static final String DB_PASSWORD = "your_password_here";
```

## Bước 6: Build Project với Maven

### Cách 1: Dùng VSCode Terminal

```bash
# Cài Maven nếu chưa có
# Download: https://maven.apache.org/download.cgi

# Build project
mvn clean install

# Hoặc package thành WAR
mvn clean package
```

### Cách 2: Dùng VSCode Maven Extension

1. Mở "MAVEN" sidebar (biểu tượng M)
2. Expand project → Lifecycle
3. Click "clean" → "install"

## Bước 7: Deploy và Run

### Cách 1: Dùng Tomcat for Java Extension

1. Mở "TOMCAT SERVERS" trong sidebar
2. Right-click Tomcat server → "Add Package"
3. Chọn file `target/RestMan.war` (sau khi build)
4. Right-click Tomcat server → "Start"
5. Truy cập: http://localhost:8080/RestMan/

### Cách 2: Copy WAR file thủ công

```bash
# Copy file WAR vào webapps của Tomcat
cp target/RestMan.war C:/apache-tomcat-9.0.xx/webapps/

# Start Tomcat
cd C:/apache-tomcat-9.0.xx/bin
./startup.bat   # Windows
./startup.sh    # Linux/Mac
```

### Cách 3: Không dùng Maven (Manual)

1. Tạo thư mục build:
```bash
mkdir -p build/classes
```

2. Compile Java files:
```bash
javac -d build/classes -cp "WebContent/WEB-INF/lib/*;C:/apache-tomcat-9.0.xx/lib/servlet-api.jar" src/**/*.java
```

3. Tạo cấu trúc WAR:
```
RestMan/
├── META-INF/
├── WEB-INF/
│   ├── classes/ (copy từ build/classes)
│   ├── lib/
│   └── web.xml
├── css/
├── customer/
├── warehousestaff/
└── index.jsp
```

4. Deploy vào Tomcat webapps

## Bước 8: Debugging

### Enable Debug Mode:

1. `Ctrl+Shift+P` → "Java: Configure Java Runtime"
2. Đảm bảo JDK được nhận diện

3. Đặt breakpoint trong code (click vào lề trái)
4. Start Tomcat in Debug mode
5. Attach debugger: `F5`

## Troubleshooting

### Lỗi: "Cannot find Java runtime"
```bash
# Kiểm tra JAVA_HOME
echo %JAVA_HOME%  # Windows
echo $JAVA_HOME   # Linux/Mac

# Set JAVA_HOME trong VSCode settings.json
"java.home": "C:\\Program Files\\Java\\jdk-11.0.xx"
```

### Lỗi: "package javax.servlet does not exist"
```bash
# Ensure Maven dependencies downloaded
mvn dependency:resolve

# Hoặc add servlet-api.jar manually vào classpath
```

### Lỗi: "Port 8080 already in use"
```bash
# Windows: Kill process using port 8080
netstat -ano | findstr :8080
taskkill /PID <PID> /F

# Linux/Mac:
lsof -ti:8080 | xargs kill -9
```

### Lỗi: MySQL Connection refused
```bash
# Check MySQL is running
# Windows:
net start MySQL80

# Linux:
sudo systemctl start mysql

# Mac:
mysql.server start
```

### Lỗi: ClassNotFoundException
```bash
# Ensure mysql-connector-java.jar in:
# - WebContent/WEB-INF/lib/
# - Maven dependencies (pom.xml)
```

## Hot Reload (không cần restart)

1. Install "Live Server" extension
2. Với JSP files: Save → tự reload
3. Với Java files: Cần rebuild và restart Tomcat

## Cấu trúc Project chuẩn cho VSCode

```
RestMan/
├── .vscode/
│   ├── settings.json
│   └── launch.json
├── src/
│   ├── dao/
│   ├── model/
│   └── servlet/
├── WebContent/
│   ├── WEB-INF/
│   │   ├── lib/
│   │   │   └── mysql-connector-java-8.x.x.jar
│   │   └── web.xml
│   ├── css/
│   ├── customer/
│   └── warehousestaff/
├── database/
│   └── restman.sql
├── pom.xml (Maven)
└── README.md
```

## Kiểm tra Setup thành công

1. **Java**: `java -version` → JDK 8+
2. **Maven**: `mvn -version` → Maven 3.x
3. **MySQL**: `mysql -V` → MySQL 8.0
4. **Tomcat**: Check `http://localhost:8080` → Tomcat homepage

## Chạy lần đầu

```bash
# 1. Import database
mysql -u root -p < database/restman.sql

# 2. Build project
mvn clean package

# 3. Deploy
# Copy target/RestMan.war to Tomcat webapps/

# 4. Start Tomcat
# Dùng VSCode extension hoặc terminal

# 5. Access
# http://localhost:8080/RestMan/
```

## VSCode Shortcuts hữu ích

- `Ctrl+Shift+P`: Command Palette
- `Ctrl+P`: Quick Open file
- `F5`: Start Debugging
- `Shift+F5`: Stop Debugging
- `Ctrl+Shift+B`: Build
- `Ctrl+\``: Toggle Terminal
- `Alt+Shift+F`: Format code

## Liên kết hữu ích

- [VSCode Java Extension](https://code.visualstudio.com/docs/java/java-webapp)
- [Tomcat Documentation](https://tomcat.apache.org/tomcat-9.0-doc/)
- [Maven Guide](https://maven.apache.org/guides/getting-started/)
- [MySQL Connector/J](https://dev.mysql.com/downloads/connector/j/)

---

Nếu gặp vấn đề, kiểm tra:
1. Java và Maven đã cài đúng chưa
2. MySQL đang chạy chưa
3. Tomcat đã cấu hình đúng chưa
4. Database connection trong DAO.java đúng chưa
5. File WAR đã build thành công chưa
