@echo off
color 0B
echo ==========================================
echo   Building Windows Package
echo ==========================================
echo.

REM Check Node.js
node --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Node.js not found! Install from https://nodejs.org/
    pause
    exit /b 1
)

echo ✅ Node.js found
echo.

REM Install dependencies
echo 📦 Step 1: Installing dependencies...
if exist "pnpm-lock.yaml" (
    pnpm install
) else (
    npm install
)
if errorlevel 1 (
    echo ❌ Failed to install dependencies
    pause
    exit /b 1
)

echo ✅ Dependencies installed
echo.

REM Build the project
echo 🏗️ Step 2: Building project...
pnpm run build
if errorlevel 1 (
    npm run build
    if errorlevel 1 (
        echo ❌ Build failed
        pause
        exit /b 1
    )
)

echo ✅ Build completed
echo.

REM Create package directory
echo 📦 Step 3: Creating Windows package...
if exist "windows-package" rmdir /s /q "windows-package"
mkdir "windows-package"

REM Copy built files
xcopy "dist" "windows-package\dist\" /E /I /Q
copy "run.bat" "windows-package\"

REM Create simple start script for package
echo @echo off > "windows-package\start.bat"
echo color 0A >> "windows-package\start.bat"
echo echo Transaction Manager - Starting... >> "windows-package\start.bat"
echo echo. >> "windows-package\start.bat"
echo timeout /t 2 /nobreak ^>nul >> "windows-package\start.bat"
echo start "" "http://localhost:3000" >> "windows-package\start.bat"
echo node dist\server\production.mjs >> "windows-package\start.bat"
echo pause >> "windows-package\start.bat"

REM Create README
echo # Transaction Manager - Windows Package > "windows-package\README.txt"
echo. >> "windows-package\README.txt"
echo Quick Start: >> "windows-package\README.txt"
echo 1. Make sure Node.js is installed (https://nodejs.org/) >> "windows-package\README.txt"
echo 2. Double-click start.bat >> "windows-package\README.txt"
echo 3. Browser will open automatically >> "windows-package\README.txt"
echo. >> "windows-package\README.txt"
echo Requirements: >> "windows-package\README.txt"
echo - Node.js v16 or higher >> "windows-package\README.txt"
echo - Modern web browser >> "windows-package\README.txt"

echo.
echo ✅ Package created successfully!
echo.
echo 📂 Location: windows-package\
echo 📁 Contents:
echo    • dist\ - Application files
echo    • start.bat - Launch script
echo    • README.txt - Instructions
echo.
echo 🧪 Test: Go to windows-package\ and run start.bat
echo 📦 Distribute: Zip the windows-package\ folder
echo.
pause
