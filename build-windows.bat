@echo off
color 0B
echo ==========================================
echo   Building Windows Package
echo ==========================================
echo.

REM Check Node.js
node --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Node.js not found!
    echo Download from: https://nodejs.org/
    pause
    exit /b 1
)

echo ✅ Node.js found:
node --version
echo.

REM Check package manager and install dependencies
where pnpm >nul 2>&1
if errorlevel 1 (
    echo 📦 Using npm...
    set PKG_MGR=npm
) else (
    echo 📦 Using pnpm...
    set PKG_MGR=pnpm
)

echo 📥 Step 1: Installing dependencies...
%PKG_MGR% install
if errorlevel 1 (
    echo ❌ Failed to install dependencies
    pause
    exit /b 1
)

echo ✅ Dependencies installed
echo.

REM Build the project
echo 🏗️ Step 2: Building project...
%PKG_MGR% run build
if errorlevel 1 (
    echo ❌ Build failed - check errors above
    pause
    exit /b 1
)

echo ✅ Build completed successfully
echo.

REM Verify build output
echo 🔍 Step 3: Verifying build...
if not exist "dist\spa\index.html" (
    echo ❌ Frontend build missing: dist\spa\index.html
    pause
    exit /b 1
)

if not exist "dist\server\production.mjs" (
    echo ❌ Server build missing: dist\server\production.mjs
    pause
    exit /b 1
)

echo ✅ Build verification passed
echo.

REM Create distribution package
echo 📦 Step 4: Creating Windows package...
if exist "windows-package" rmdir /s /q "windows-package"
mkdir "windows-package"

REM Copy all necessary files
echo 📋 Copying files...
xcopy "dist" "windows-package\dist\" /E /I /Q
copy "run.bat" "windows-package\"

REM Create simple launcher
echo @echo off > "windows-package\start.bat"
echo color 0A >> "windows-package\start.bat"
echo echo ========================================== >> "windows-package\start.bat"
echo echo     Transaction Manager - Windows >> "windows-package\start.bat"
echo echo ========================================== >> "windows-package\start.bat"
echo echo. >> "windows-package\start.bat"
echo echo 🚀 Starting Transaction Manager... >> "windows-package\start.bat"
echo echo 📋 Requirements: Node.js from https://nodejs.org/ >> "windows-package\start.bat"
echo echo 🌐 Browser will open to: http://localhost:3000 >> "windows-package\start.bat"
echo echo 🛑 Close this window to stop the server >> "windows-package\start.bat"
echo echo. >> "windows-package\start.bat"
echo node --version ^>nul 2^>^&1 >> "windows-package\start.bat"
echo if errorlevel 1 ^( >> "windows-package\start.bat"
echo     echo ❌ Node.js required! Download from: https://nodejs.org/ >> "windows-package\start.bat"
echo     pause >> "windows-package\start.bat"
echo     exit /b 1 >> "windows-package\start.bat"
echo ^) >> "windows-package\start.bat"
echo echo ✅ Node.js found >> "windows-package\start.bat"
echo timeout /t 3 /nobreak ^>nul >> "windows-package\start.bat"
echo start "" "http://localhost:3000" >> "windows-package\start.bat"
echo echo ✨ Starting server... >> "windows-package\start.bat"
echo node dist\server\production.mjs >> "windows-package\start.bat"
echo pause >> "windows-package\start.bat"

REM Create package README
echo # Transaction Manager - Windows Package > "windows-package\README.txt"
echo. >> "windows-package\README.txt"
echo ## Quick Start >> "windows-package\README.txt"
echo 1. Install Node.js from https://nodejs.org/ >> "windows-package\README.txt"
echo 2. Double-click start.bat >> "windows-package\README.txt"
echo 3. Browser opens automatically >> "windows-package\README.txt"
echo 4. Start using Transaction Manager! >> "windows-package\README.txt"
echo. >> "windows-package\README.txt"
echo ## What's Inside >> "windows-package\README.txt"
echo - dist\spa\ - Web application files >> "windows-package\README.txt"
echo - dist\server\production.mjs - Server application >> "windows-package\README.txt"
echo - start.bat - One-click launcher >> "windows-package\README.txt"
echo - run.bat - Alternative launcher >> "windows-package\README.txt"
echo. >> "windows-package\README.txt"
echo ## Requirements >> "windows-package\README.txt"
echo - Windows 10 or 11 >> "windows-package\README.txt"
echo - Node.js v16+ >> "windows-package\README.txt"
echo - Modern web browser >> "windows-package\README.txt"
echo. >> "windows-package\README.txt"
echo ## Features >> "windows-package\README.txt"
echo - Complete transaction management >> "windows-package\README.txt"
echo - Customer database >> "windows-package\README.txt"
echo - Data import/export ^(PDF, Excel^) >> "windows-package\README.txt"
echo - Monthly reports and analytics >> "windows-package\README.txt"
echo - Automatic data backup >> "windows-package\README.txt"
echo - Works completely offline >> "windows-package\README.txt"

echo ✅ Package created successfully!
echo.

REM Test the package
echo 🧪 Step 5: Testing package...
set /p TEST_PACKAGE="Test the package now? (Y/N): "
if /i "%TEST_PACKAGE%"=="Y" (
    echo.
    echo 🚀 Testing package...
    echo Starting test server for 10 seconds...
    cd windows-package
    start /min cmd /c "timeout /t 10 && taskkill /f /im node.exe 2>nul"
    start /min cmd /c "node dist\server\production.mjs"
    cd ..
    timeout /t 3 /nobreak >nul
    start "" "http://localhost:3000"
    echo.
    echo ✅ Test server started
    echo 🌐 Check your browser - should show Transaction Manager
    echo.
    timeout /t 8
    echo 🛑 Stopping test server...
    taskkill /f /im node.exe >nul 2>&1
)

echo.
echo ==========================================
echo       WINDOWS PACKAGE READY!
echo ==========================================
echo.
echo 📂 Location: windows-package\
echo 📁 Files created:
dir /b "windows-package"
echo.
echo 🚀 To use: Go to windows-package\ and run start.bat
echo 📦 To share: Zip the windows-package\ folder
echo.
echo ✨ Package size: Approximately 5-10 MB
echo 🎯 Target: Windows users with Node.js
echo.
pause
