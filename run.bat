@echo off
color 0A
echo ==========================================
echo     Transaction Manager - Starting...
echo ==========================================
echo.

REM Check if production build exists
if exist "dist\server\production.mjs" (
    echo 🚀 Production mode detected
    echo 📂 Using built files from dist\
    echo.
    
    REM Check Node.js for production
    node --version >nul 2>&1
    if errorlevel 1 (
        echo ❌ Node.js required for production mode
        echo Download from: https://nodejs.org/
        pause
        exit /b 1
    )
    
    echo ✅ Node.js found:
    node --version
    echo.
    echo 🌐 Starting on: http://localhost:3000
    echo 🚀 Browser will open in 3 seconds...
    echo.
    timeout /t 3 /nobreak >nul
    start "" "http://localhost:3000"
    echo.
    echo ✨ Transaction Manager starting...
    echo 🛑 Press Ctrl+C to stop
    echo.
    node dist\server\production.mjs
    
) else (
    echo 🔧 Development mode - setting up...
    echo.
    
    REM Check Node.js
    node --version >nul 2>&1
    if errorlevel 1 (
        echo ❌ Node.js required! Download from: https://nodejs.org/
        pause
        exit /b 1
    )
    
    echo ✅ Node.js found:
    node --version
    echo.
    
    REM Check package manager
    where pnpm >nul 2>&1
    if errorlevel 1 (
        echo 📦 Using npm...
        set PKG_MGR=npm
    ) else (
        echo 📦 Using pnpm...
        set PKG_MGR=pnpm
    )
    
    REM Install dependencies if needed
    if not exist "node_modules" (
        echo 📥 Installing dependencies...
        echo This may take a few minutes...
        %PKG_MGR% install
        if errorlevel 1 (
            echo ❌ Failed to install dependencies
            pause
            exit /b 1
        )
        echo ✅ Dependencies installed!
        echo.
    )
    
    echo 🌐 Starting development server on: http://localhost:7020
    echo 🚀 Browser will open in 3 seconds...
    echo.
    timeout /t 3 /nobreak >nul
    start "" "http://localhost:7020"
    echo.
    echo ✨ Transaction Manager starting...
    echo 🛑 Press Ctrl+C to stop
    echo.
    %PKG_MGR% run dev
)

if errorlevel 1 (
    echo.
    echo ❌ Server failed to start
    echo.
    echo Common solutions:
    echo 1. Check if the port is already in use
    echo 2. Try restarting your computer
    echo 3. Run as Administrator
    echo.
)

pause
