@echo off
chcp 65001 >nul
echo ========================================
echo   STARTING TOMCAT SERVER
echo ========================================
echo.

REM Find Tomcat
set TOMCAT_PATH=C:\apache-tomcat-9.0.80

if not exist "%TOMCAT_PATH%" (
    set TOMCAT_PATH=C:\apache-tomcat-9.0.78
)

if not exist "%TOMCAT_PATH%" (
    set TOMCAT_PATH=C:\Program Files\Apache Software Foundation\Tomcat 9.0
)

if not exist "%TOMCAT_PATH%" (
    echo ❌ Cannot find Tomcat installation!
    set /p TOMCAT_PATH="Enter Tomcat installation path: "
)

if not exist "%TOMCAT_PATH%\bin\catalina.bat" (
    echo ❌ Invalid Tomcat path!
    pause
    exit /b 1
)

echo Found Tomcat at: %TOMCAT_PATH%
echo.

REM Check if WAR exists
if exist "target\RestMan.war" (
    echo Deploying WAR file to Tomcat...
    copy /y "target\RestMan.war" "%TOMCAT_PATH%\webapps\" >nul
    echo ✅ Deployed target\RestMan.war
) else if exist "WebContent" (
    echo No WAR file found, deploying WebContent folder...
    if not exist "%TOMCAT_PATH%\webapps\RestMan" mkdir "%TOMCAT_PATH%\webapps\RestMan"
    xcopy /s /y /i WebContent\* "%TOMCAT_PATH%\webapps\RestMan\" >nul
    xcopy /s /y /i build\classes\* "%TOMCAT_PATH%\webapps\RestMan\WEB-INF\classes\" >nul
    echo ✅ Deployed WebContent to Tomcat
) else (
    echo ❌ No deployable content found!
    echo Please run build.bat first
    pause
    exit /b 1
)

echo.
echo Starting Tomcat server...
echo Press Ctrl+C to stop the server
echo.

cd /d "%TOMCAT_PATH%\bin"
call catalina.bat run

pause
