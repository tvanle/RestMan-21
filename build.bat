@echo off
chcp 65001 >nul
echo ========================================
echo   BUILDING RESTMAN PROJECT
echo ========================================
echo.

REM Check if Maven exists
mvn -version >nul 2>&1
if errorlevel 1 (
    echo Maven not found, using manual build...
    goto MANUAL_BUILD
) else (
    goto MAVEN_BUILD
)

:MAVEN_BUILD
echo Using Maven to build...
echo.
call mvn clean package
if errorlevel 1 (
    echo ❌ Maven build failed!
    pause
    exit /b 1
)
echo.
echo ✅ Build successful!
echo WAR file: target\RestMan.war
goto END

:MANUAL_BUILD
echo Creating build directories...
if not exist "build\classes" mkdir "build\classes"
if not exist "WebContent\WEB-INF\classes" mkdir "WebContent\WEB-INF\classes"

echo.
echo Compiling Java files...

REM Find Tomcat path
set TOMCAT_PATH=C:\apache-tomcat-9.0.80
if not exist "%TOMCAT_PATH%" (
    set /p TOMCAT_PATH="Enter Tomcat installation path: "
)

if not exist "%TOMCAT_PATH%\lib\servlet-api.jar" (
    echo ❌ Cannot find servlet-api.jar in Tomcat!
    echo Please check Tomcat installation path.
    pause
    exit /b 1
)

REM Compile
javac -encoding UTF-8 -d build\classes -cp "WebContent\WEB-INF\lib\*;%TOMCAT_PATH%\lib\servlet-api.jar" src\dao\*.java src\model\*.java src\servlet\*.java

if errorlevel 1 (
    echo ❌ Compilation failed!
    pause
    exit /b 1
)

echo Copying compiled classes...
xcopy /s /y build\classes\* WebContent\WEB-INF\classes\ >nul

echo.
echo ✅ Build successful!
echo Compiled classes: WebContent\WEB-INF\classes\

:END
echo.
echo ========================================
echo Next steps:
echo 1. Deploy to Tomcat:
echo    - Copy target\RestMan.war to Tomcat webapps\
echo    - OR use VSCode Tomcat extension
echo 2. Start Tomcat server
echo 3. Access: http://localhost:8080/RestMan/
echo ========================================
echo.
pause
