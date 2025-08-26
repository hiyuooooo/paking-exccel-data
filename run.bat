@echo off
color 0A
echo ==========================================
echo   Transaction Manager - Portable Version
echo ==========================================
echo.
echo Welcome! Starting your portable transaction manager...
echo This is a pre-built version that runs directly!
echo.

REM Check if Node.js is installed
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Node.js is not installed or not in PATH
    echo Please install Node.js from https://nodejs.org/
    echo.
    pause
    exit /b 1
)

REM Check if pnpm is installed
pnpm --version >nul 2>&1
if %errorlevel% neq 0 (
    echo PNPM not found. Installing PNPM...
    npm install -g pnpm
    if %errorlevel% neq 0 (
        echo ERROR: Failed to install PNPM
        pause
        exit /b 1
    )
)

echo Node.js version:
node --version
echo.
echo PNPM version:
pnpm --version
echo.

REM Check if build exists
if not exist "dist\local\index.html" (
    echo Building the application...
    echo This may take a moment...
    pnpm run build:local
    if %errorlevel% neq 0 (
        echo ERROR: Failed to build the application
        pause
        exit /b 1
    )
    echo.
    echo Build completed successfully!
    echo.
)

echo ==========================================
echo       STARTING TRANSACTION MANAGER
echo ==========================================
echo.
echo ✅ Portable Version Ready!
echo ✅ Server starting on: http://localhost:7020
echo ✅ Browser will open automatically
echo.
echo 📝 To add transactions: Press 'A' key
echo 💾 To backup data: Go to 'Backup' tab
echo 🛑 To stop: Press Ctrl+C in this window
echo.
echo ==========================================
echo.

REM Start the production server
echo 🚀 Starting production server...
echo.
echo Opening browser in 3 seconds...

REM Wait a moment then open browser
timeout /t 3 /nobreak >nul
start "" "http://localhost:7020"

echo.
echo ✨ Transaction Manager is running...
echo.
pnpm run start:local

REM If start:local fails, keep window open to show error
if %errorlevel% neq 0 (
    echo.
    echo ERROR: Failed to start the server
    echo Please check the error messages above
    pause
)
