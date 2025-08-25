@echo off
echo Starting Simple Transaction Manager...

REM Check if Node.js is installed (for npx serve)
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo WARNING: Node.js not found. Using basic server mode.
    echo For best experience, install Node.js from https://nodejs.org/
    echo.
    echo Opening simple-index.html directly...
    start "" "public\simple-index.html"
    pause
    exit /b 0
)

echo Node.js found. Starting local web server...
echo URL: http://localhost:8080/simple-index.html
echo.
timeout /t 3 /nobreak > nul
start "" "http://localhost:8080/simple-index.html"
echo.
echo Simple Transaction Manager Server Running
echo Keep this window open to keep the server active.
echo Press Ctrl+C to stop the server.
echo.
npx serve public -p 8080
