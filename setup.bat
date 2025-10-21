@echo off
chcp 65001 >nul
echo ========================================
echo   RESTMAN - AUTO SETUP SCRIPT
echo ========================================
echo.

REM Check Java
echo [1/7] Checking Java...
java -version >nul 2>&1
if errorlevel 1 (
    echo ❌ Java not found! Please install JDK 8 or higher.
    echo Download: https://adoptium.net/
    pause
    exit /b 1
) else (
    echo ✅ Java installed
)

REM Check MySQL
echo.
echo [2/7] Checking MySQL...
mysql --version >nul 2>&1
if errorlevel 1 (
    echo ⚠️  MySQL not found in PATH
    echo If MySQL is installed, you can skip this
) else (
    echo ✅ MySQL found
)

REM Check Maven
echo.
echo [3/7] Checking Maven...
mvn -version >nul 2>&1
if errorlevel 1 (
    echo ⚠️  Maven not found - will use manual build
    set USE_MAVEN=0
) else (
    echo ✅ Maven found
    set USE_MAVEN=1
)

REM Create directories
echo.
echo [4/7] Creating directories...
if not exist "WebContent\WEB-INF\lib" mkdir "WebContent\WEB-INF\lib"
if not exist "WebContent\WEB-INF\classes" mkdir "WebContent\WEB-INF\classes"
if not exist "build\classes" mkdir "build\classes"
echo ✅ Directories created

REM Check MySQL Connector
echo.
echo [5/7] Checking MySQL Connector...
if exist "WebContent\WEB-INF\lib\mysql-connector-java-*.jar" (
    echo ✅ MySQL Connector found
) else (
    echo ❌ MySQL Connector not found!
    echo.
    echo Please download MySQL Connector/J:
    echo 1. Go to: https://dev.mysql.com/downloads/connector/j/
    echo 2. Download Platform Independent ZIP
    echo 3. Extract and copy mysql-connector-java-X.X.XX.jar
    echo 4. Paste to: WebContent\WEB-INF\lib\
    echo.
    pause
)

REM Setup Database
echo.
echo [6/7] Database Setup
echo =====================================
echo Please setup database manually:
echo.
echo Method 1: Command line
echo   mysql -u root -p ^< database\restman.sql
echo.
echo Method 2: MySQL Workbench
echo   File -^> Open SQL Script -^> database\restman.sql -^> Execute
echo.
echo After setup, press any key to continue...
pause >nul

REM Configure Database Connection
echo.
echo [7/7] Configure Database Connection
echo =====================================
echo.
set /p DB_USER="Enter MySQL username [root]: " || set DB_USER=root
set /p DB_PASS="Enter MySQL password: "
echo.

REM Update DAO.java
echo Updating database configuration in src\dao\DAO.java...
powershell -Command "(Get-Content src\dao\DAO.java) -replace 'private static final String DB_USER = \".*\";', 'private static final String DB_USER = \"%DB_USER%\";' | Set-Content src\dao\DAO.java"
powershell -Command "(Get-Content src\dao\DAO.java) -replace 'private static final String DB_PASSWORD = \".*\";', 'private static final String DB_PASSWORD = \"%DB_PASS%\";' | Set-Content src\dao\DAO.java"
echo ✅ Database configuration updated

echo.
echo ========================================
echo   SETUP COMPLETED!
echo ========================================
echo.
echo Next steps:
echo 1. Open this project in VSCode
echo 2. Install extensions: Extension Pack for Java, Tomcat for Java
echo 3. Configure Tomcat server in VSCode
echo 4. Run build.bat to build the project
echo 5. Deploy and start Tomcat
echo.
echo For detailed instructions, see INSTALL.md
echo.
pause
