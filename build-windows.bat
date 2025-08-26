@echo off
setlocal enabledelayedexpansion
color 0B

echo ==========================================
echo   Building Windows Executable Package
echo ==========================================
echo.

REM Check if Node.js is installed
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ ERROR: Node.js is not installed
    echo Please install Node.js from https://nodejs.org/
    pause
    exit /b 1
)

REM Check if pnpm is installed, if not use npm
pnpm --version >nul 2>&1
if %errorlevel% neq 0 (
    echo 📦 Using npm (pnpm not found)
    set PKG_MANAGER=npm
) else (
    echo 📦 Using pnpm
    set PKG_MANAGER=pnpm
)

echo.
echo 🔧 Step 1: Installing dependencies...
%PKG_MANAGER% install
if %errorlevel% neq 0 (
    echo ❌ Failed to install dependencies
    pause
    exit /b 1
)

echo.
echo 🏗️  Step 2: Building client application...
%PKG_MANAGER% run build:client
if %errorlevel% neq 0 (
    echo ❌ Failed to build client
    pause
    exit /b 1
)

echo.
echo 🏗️  Step 3: Building server application...
%PKG_MANAGER% run build:server
if %errorlevel% neq 0 (
    echo ❌ Failed to build server
    pause
    exit /b 1
)

echo.
echo 📦 Step 4: Installing pkg for executable creation...
npm install -g pkg
if %errorlevel% neq 0 (
    echo ❌ Failed to install pkg
    pause
    exit /b 1
)

echo.
echo 📦 Step 5: Creating Windows executable...

REM Create the executable using pkg
pkg dist/server/production.mjs --targets node18-win-x64 --output transaction-manager.exe
if %errorlevel% neq 0 (
    echo ❌ Failed to create executable
    pause
    exit /b 1
)

echo.
echo 📁 Step 6: Creating distribution package...

REM Create distribution folder
if exist "windows-package" rmdir /s /q "windows-package"
mkdir "windows-package"

REM Copy necessary files
copy "transaction-manager.exe" "windows-package\"
copy "run.bat" "windows-package\"
copy "LOCAL_DEPLOYMENT.md" "windows-package\INSTALLATION-GUIDE.md"
xcopy "dist\spa" "windows-package\dist\spa\" /E /I /Q
mkdir "windows-package\dist\server"
copy "dist\server\production.mjs" "windows-package\dist\server\"

REM Create simplified run.bat for distribution
echo @echo off > "windows-package\start-app.bat"
echo color 0A >> "windows-package\start-app.bat"
echo echo ========================================== >> "windows-package\start-app.bat"
echo echo     Transaction Manager - Starting... >> "windows-package\start-app.bat"
echo echo ========================================== >> "windows-package\start-app.bat"
echo echo. >> "windows-package\start-app.bat"
echo echo 🚀 Starting Transaction Manager... >> "windows-package\start-app.bat"
echo echo 🌐 Browser will open automatically >> "windows-package\start-app.bat"
echo echo 🛑 Close this window to stop the app >> "windows-package\start-app.bat"
echo echo. >> "windows-package\start-app.bat"
echo timeout /t 2 /nobreak ^>nul >> "windows-package\start-app.bat"
echo start "" "http://localhost:3000" >> "windows-package\start-app.bat"
echo echo ✨ Running on: http://localhost:3000 >> "windows-package\start-app.bat"
echo echo. >> "windows-package\start-app.bat"
echo "%~dp0transaction-manager.exe" >> "windows-package\start-app.bat"
echo pause >> "windows-package\start-app.bat"

REM Create README for the package
echo # Transaction Manager - Windows Standalone Version > "windows-package\README.txt"
echo. >> "windows-package\README.txt"
echo ## Quick Start >> "windows-package\README.txt"
echo 1. Double-click "start-app.bat" to run the application >> "windows-package\README.txt"
echo 2. Your browser will open automatically >> "windows-package\README.txt"
echo 3. Close the command window to stop the application >> "windows-package\README.txt"
echo. >> "windows-package\README.txt"
echo ## What's Included >> "windows-package\README.txt"
echo - transaction-manager.exe: Main application server >> "windows-package\README.txt"
echo - start-app.bat: Quick launcher script >> "windows-package\README.txt"
echo - dist/: Web application files >> "windows-package\README.txt"
echo - INSTALLATION-GUIDE.md: Detailed instructions >> "windows-package\README.txt"
echo. >> "windows-package\README.txt"
echo ## Requirements >> "windows-package\README.txt"
echo - Windows 10 or Windows 11 >> "windows-package\README.txt"
echo - No additional software needed >> "windows-package\README.txt"
echo - Web browser (Chrome, Firefox, Edge) >> "windows-package\README.txt"
echo. >> "windows-package\README.txt"
echo ## Features >> "windows-package\README.txt"
echo - Complete transaction management >> "windows-package\README.txt"
echo - Customer database >> "windows-package\README.txt"
echo - Data import/export (PDF, Excel) >> "windows-package\README.txt"
echo - Monthly reports and summaries >> "windows-package\README.txt"
echo - Automatic data backup >> "windows-package\README.txt"
echo - Runs entirely offline >> "windows-package\README.txt"

echo.
echo ✅ Build completed successfully!
echo.
echo 📂 Package location: windows-package\
echo 📁 Contents:
echo    • transaction-manager.exe (standalone server)
echo    • start-app.bat (quick launcher)
echo    • dist\ (web application files)
echo    • README.txt (user instructions)
echo    • INSTALLATION-GUIDE.md (detailed guide)
echo.
echo 🚀 To test: Go to windows-package\ and run start-app.bat
echo 📦 To distribute: Zip the windows-package\ folder
echo.
echo ==========================================
echo     Build Process Complete! 
echo ==========================================
pause
