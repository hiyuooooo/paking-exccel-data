@echo off
color 0A
echo ==========================================
echo   Transaction Manager - Web Application
echo ==========================================
echo.
echo Starting local web server...
echo.

REM Check if Node.js is installed
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo WARNING: Node.js not found!
    echo.
    echo Option 1: Install Node.js from https://nodejs.org/
    echo Option 2: Open webapp\index.html directly in your browser
    echo.
    echo Opening web app directly in browser...
    timeout /t 3 /nobreak > nul
    start "" "webapp\index.html"
    echo.
    echo Note: Some features may not work without a local server.
    pause
    exit /b 0
)

echo ✅ Node.js found!
echo ✅ Installing local server package...
echo.

REM Install http-server globally if not exists
npm list -g http-server >nul 2>&1
if %errorlevel% neq 0 (
    echo Installing http-server...
    npm install -g http-server
    if %errorlevel% neq 0 (
        echo ERROR: Failed to install http-server
        echo Trying alternative method...
        goto USE_NPX
    )
)

echo ✅ Starting web server...
echo.
echo URL: http://localhost:8080
echo Web App: http://localhost:8080/webapp/
echo.
timeout /t 3 /nobreak > nul
start "" "http://localhost:8080/webapp/"
echo.
echo 🚀 Transaction Manager Web App Running!
echo 📱 Access at: http://localhost:8080/webapp/
echo 🛑 Press Ctrl+C to stop the server
echo 💡 Keep this window open to keep server running
echo.
http-server -p 8080 -o

goto END

:USE_NPX
echo ✅ Using npx serve...
echo.
echo URL: http://localhost:8080
echo.
timeout /t 3 /nobreak > nul
start "" "http://localhost:8080/webapp/"
echo.
echo 🚀 Transaction Manager Web App Running!
echo 📱 Access at: http://localhost:8080/webapp/
echo 🛑 Press Ctrl+C to stop the server
echo.
npx serve . -p 8080

:END
echo.
echo Server stopped.
pause
