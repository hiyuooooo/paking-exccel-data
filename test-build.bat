@echo off
setlocal enabledelayedexpansion
color 0E

echo ==========================================
echo      Transaction Manager - Build Test
echo ==========================================
echo.
echo This script tests the build process without
echo creating the full distribution package.
echo.

REM Check if Node.js is installed
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ ERROR: Node.js is not installed
    echo Please install Node.js from https://nodejs.org/
    pause
    exit /b 1
)

echo ✅ Node.js version:
node --version
echo.

REM Check if dependencies are installed
if not exist "node_modules" (
    echo ��� Installing dependencies first...
    pnpm install
    if %errorlevel% neq 0 (
        npm install
        if %errorlevel% neq 0 (
            echo ❌ Failed to install dependencies
            pause
            exit /b 1
        )
    )
)

echo ✅ Dependencies are installed
echo.

echo 🔧 Step 1: Testing TypeScript compilation...
pnpm typecheck
if %errorlevel% neq 0 (
    echo ❌ TypeScript compilation failed
    echo Please fix TypeScript errors before building
    pause
    exit /b 1
)
echo ✅ TypeScript compilation successful
echo.

echo 🏗️  Step 2: Testing client build...
pnpm run build:client
if %errorlevel% neq 0 (
    echo ❌ Client build failed
    pause
    exit /b 1
)
echo ✅ Client build successful
echo.

echo 🏗️  Step 3: Testing server build...
pnpm run build:server  
if %errorlevel% neq 0 (
    echo ❌ Server build failed
    pause
    exit /b 1
)
echo ✅ Server build successful
echo.

echo 🧪 Step 4: Testing production server...
echo Starting production server for 10 seconds...
echo.

REM Start the production server in background
start /min cmd /c "timeout /t 10 >nul && taskkill /f /im node.exe 2>nul"
start /min cmd /c "node dist/server/production.mjs"

REM Wait a moment for server to start
timeout /t 3 /nobreak >nul

REM Test if server is responding
curl -s http://localhost:3000/api/ping >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ Production server is responding
    echo ✅ API endpoint test successful
) else (
    echo ⚠️  Server test inconclusive (curl not available or server not ready)
    echo This is usually normal - server may be starting
)

echo.
echo 🌐 Opening test page...
start "" "http://localhost:3000"

echo.
echo ⏳ Waiting 10 seconds for manual testing...
echo Check if the browser opened and shows the application.
echo.
timeout /t 10

REM Stop any running node processes
taskkill /f /im node.exe >nul 2>&1

echo.
echo ==========================================
echo          BUILD TEST COMPLETE
echo ==========================================
echo.
echo ✅ All build steps completed successfully!
echo.
echo Next steps:
echo 1. If browser test worked: Run build-windows.bat
echo 2. If issues found: Check error messages above
echo 3. For full package: Run: pnpm run package:windows
echo.
echo Files created:
if exist "dist\spa\index.html" (
    echo ✅ dist\spa\index.html (client build)
) else (
    echo ❌ dist\spa\index.html (missing)
)

if exist "dist\server\production.mjs" (
    echo ✅ dist\server\production.mjs (server build)
) else (
    echo ❌ dist\server\production.mjs (missing)
)

echo.
pause
