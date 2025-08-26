@echo off
setlocal enabledelayedexpansion
color 0A

echo ==========================================
echo     Transaction Manager - Local Server
echo ==========================================
echo.

REM Set application details
set APP_NAME=Transaction Manager
set APP_PORT=7020
set APP_URL=http://localhost:!APP_PORT!

REM Check if we're running as a packaged executable or development mode
if exist "%~dp0\dist\server\production.mjs" (
    set RUN_MODE=PRODUCTION
    echo 🚀 Running in PRODUCTION mode
) else (
    set RUN_MODE=DEVELOPMENT  
    echo 🔧 Running in DEVELOPMENT mode
)

echo.
echo Welcome! Starting your local %APP_NAME%...
echo This application runs entirely on your computer.
echo.

REM Production mode - run the packaged app
if "!RUN_MODE!"=="PRODUCTION" (
    echo ✅ Production build detected
    echo ✅ Server starting on: !APP_URL!
    echo ✅ Browser will open automatically
    echo.
    echo 📝 Features available:
    echo    • Transaction Management
    echo    • Customer Database  
    echo    • Data Import/Export
    echo    • Monthly Reports
    echo    • Automatic Backups
    echo.
    echo 🛑 To stop: Close this window or press Ctrl+C
    echo.
    echo ==========================================
    echo.
    
    REM Wait a moment then open browser
    echo 🚀 Starting server...
    timeout /t 2 /nobreak >nul
    start "" "!APP_URL!"
    
    echo.
    echo ✨ %APP_NAME% is running...
    echo.
    
    REM Run the production server
    node "%~dp0\dist\server\production.mjs"
    
) else (
    REM Development mode - install dependencies and run dev server
    echo 🔧 Development mode requires Node.js and dependencies
    echo.
    
    REM Check if Node.js is installed
    node --version >nul 2>&1
    if !errorlevel! neq 0 (
        echo ❌ ERROR: Node.js is not installed
        echo.
        echo Please install Node.js from: https://nodejs.org/
        echo Minimum version required: v16.0.0
        echo.
        echo After installing Node.js, run this file again.
        echo.
        pause
        exit /b 1
    )

    REM Check if pnpm is installed
    pnpm --version >nul 2>&1
    if !errorlevel! neq 0 (
        echo 📦 PNPM not found. Installing PNPM...
        npm install -g pnpm
        if !errorlevel! neq 0 (
            echo ❌ ERROR: Failed to install PNPM
            echo Trying with npm instead...
            set PACKAGE_MANAGER=npm
        ) else (
            set PACKAGE_MANAGER=pnpm
        )
    ) else (
        set PACKAGE_MANAGER=pnpm
    )

    echo ✅ Node.js version:
    node --version
    echo.
    echo ✅ Package manager: !PACKAGE_MANAGER!
    !PACKAGE_MANAGER! --version
    echo.

    REM Check if dependencies are installed
    if not exist "node_modules" (
        echo 📦 Installing dependencies...
        echo This may take 2-5 minutes on first run...
        echo Please wait...
        echo.
        !PACKAGE_MANAGER! install
        if !errorlevel! neq 0 (
            echo ❌ ERROR: Failed to install dependencies
            echo.
            echo Try running: npm install
            echo Or check your internet connection
            echo.
            pause
            exit /b 1
        )
        echo.
        echo ✅ Dependencies installed successfully!
        echo.
    )

    echo ==========================================
    echo       STARTING %APP_NAME%
    echo ==========================================
    echo.
    echo ✅ Setup Complete!
    echo ✅ Server starting on: !APP_URL!
    echo ✅ Browser will open automatically
    echo.
    echo 📝 Application Features:
    echo    • Press 'A' key to add transactions
    echo    • Use 'Backup' tab to save data
    echo    • Import PDF/Excel files for bulk data
    echo    • Monthly summaries and reports
    echo.
    echo 🛑 To stop: Press Ctrl+C in this window
    echo.
    echo ==========================================
    echo.

    REM Start the development server
    echo 🚀 Starting development server...
    echo.
    echo Opening browser in 3 seconds...

    REM Wait a moment then open browser
    timeout /t 3 /nobreak >nul
    start "" "!APP_URL!"

    echo.
    echo ✨ %APP_NAME% is starting...
    echo Please wait for "ready in" message...
    echo.
    !PACKAGE_MANAGER! run dev
)

REM If we get here, something went wrong
if !errorlevel! neq 0 (
    echo.
    echo ❌ ERROR: Failed to start the server
    echo.
    echo Common solutions:
    echo 1. Port !APP_PORT! might be in use - close other applications
    echo 2. Try restarting your computer
    echo 3. Check if antivirus is blocking the application
    echo.
    echo For help, check the LOCAL_DEPLOYMENT.md file
    echo.
    pause
)

endlocal
