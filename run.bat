@echo off
color 0A
echo ==========================================
echo     Transaction Manager - Starting...
echo ==========================================
echo.

REM Check if this is production build (has dist folder) or development
if exist "dist\server\production.mjs" (
    echo 🚀 Production mode - Running standalone server
    echo 🌐 Opening http://localhost:3000
    echo.
    timeout /t 2 /nobreak >nul
    start "" "http://localhost:3000"
    echo 🚀 Starting server...
    node dist\server\production.mjs
) else (
    echo 🔧 Development mode - Installing and running
    echo.
    
    REM Check if Node.js is available
    node --version >nul 2>&1
    if errorlevel 1 (
        echo ❌ Node.js not found! Please install Node.js from https://nodejs.org/
        echo.
        pause
        exit /b 1
    )
    
    echo ✅ Node.js found
    node --version
    echo.
    
    REM Install dependencies if needed
    if not exist "node_modules" (
        echo 📦 Installing dependencies...
        pnpm install
        if errorlevel 1 (
            echo Trying with npm...
            npm install
            if errorlevel 1 (
                echo ❌ Failed to install dependencies
                pause
                exit /b 1
            )
        )
    )
    
    echo 🚀 Starting development server...
    echo 🌐 Opening http://localhost:7020
    echo.
    timeout /t 3 /nobreak >nul
    start "" "http://localhost:7020"
    
    echo ✨ Server starting... Press Ctrl+C to stop
    echo.
    pnpm dev
)

pause
