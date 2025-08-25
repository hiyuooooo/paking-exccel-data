@echo off
echo Starting Simple Transaction Manager...
echo Checking for simple-index.html...

if not exist "public\simple-index.html" (
    echo ERROR: simple-index.html not found in public folder!
    pause
    exit /b 1
)

echo URL: http://localhost:8080
timeout /t 2 /nobreak > nul
start http://localhost:8080/simple-index.html
echo.
echo Simple Transaction Manager Server Running
echo Keep this window open.
echo.
npx serve public -p 8080
