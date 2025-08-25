@echo off
color 0A
echo ==========================================
echo    Transaction Manager - Executable
echo ==========================================
echo.
echo Welcome! Starting Transaction Manager...
echo.

REM Check if executable exists
if not exist "transaction-manager.exe" (
    echo ERROR: transaction-manager.exe not found!
    echo Please make sure the executable is in the same folder as this batch file.
    echo.
    pause
    exit /b 1
)

echo ✅ Executable found
echo ✅ Server starting on: http://localhost:3000
echo ✅ Browser will open automatically
echo.
echo 📝 To add transactions: Press 'A' key  
echo 💾 To backup data: Go to 'Backup' tab
echo 🛑 To stop: Press Ctrl+C in this window or close this window
echo.
echo ==========================================
echo.

REM Start the executable server
echo 🚀 Starting Transaction Manager...
echo.
echo Opening browser in 3 seconds...

REM Start the executable in background
start "" "transaction-manager.exe"

REM Wait a moment then open browser
timeout /t 3 /nobreak >nul
start "" "http://localhost:3000"

echo.
echo ✨ Transaction Manager is running!
echo ✨ Check your browser at: http://localhost:3000
echo.
echo Press any key to stop the server...
pause >nul

REM Kill the executable
taskkill /f /im "transaction-manager.exe" >nul 2>&1
echo.
echo 🛑 Transaction Manager stopped.
pause
