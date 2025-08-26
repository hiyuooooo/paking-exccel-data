@echo off
color 0C
echo ==========================================
echo   Creating Offline Windows Package
echo ==========================================
echo.

REM Check requirements
node --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Node.js required. Install from https://nodejs.org/
    pause
    exit /b 1
)

echo ✅ Node.js found
echo.

REM Install pkg globally for creating executables
echo 📦 Installing pkg for executable creation...
npm install -g pkg
if errorlevel 1 (
    echo ⚠️ Could not install pkg globally, trying locally...
    npm install pkg --save-dev
    if errorlevel 1 (
        echo ❌ Could not install pkg. Creating package without executable...
        goto :create_package_only
    )
    set PKG_CMD=npx pkg
) else (
    set PKG_CMD=pkg
)

echo ✅ pkg installed
echo.

REM Build the project first
echo 🏗️ Building project...
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

REM Create Windows executable
echo 📦 Creating Windows executable...
%PKG_CMD% dist/server/production.mjs --targets node18-win-x64 --output transaction-manager.exe
if errorlevel 1 (
    echo ⚠️ Executable creation failed, creating package without executable...
    goto :create_package_only
)

echo ✅ Executable created: transaction-manager.exe
echo.

REM Create full offline package
:create_full_package
echo 📂 Creating offline package...
if exist "offline-package" rmdir /s /q "offline-package"
mkdir "offline-package"

REM Copy executable and files
copy "transaction-manager.exe" "offline-package\"
xcopy "dist\spa" "offline-package\dist\spa\" /E /I /Q

REM Create launcher that uses the executable
echo @echo off > "offline-package\start.bat"
echo color 0A >> "offline-package\start.bat"
echo echo ========================================== >> "offline-package\start.bat"
echo echo     Transaction Manager - Offline >> "offline-package\start.bat"
echo echo ========================================== >> "offline-package\start.bat"
echo echo. >> "offline-package\start.bat"
echo echo 🚀 Starting offline Transaction Manager... >> "offline-package\start.bat"
echo echo 🌐 Browser will open automatically >> "offline-package\start.bat"
echo echo 🛑 Close this window to stop >> "offline-package\start.bat"
echo echo. >> "offline-package\start.bat"
echo timeout /t 2 /nobreak ^>nul >> "offline-package\start.bat"
echo start "" "http://localhost:3000" >> "offline-package\start.bat"
echo echo ✨ Running on http://localhost:3000 >> "offline-package\start.bat"
echo "%~dp0transaction-manager.exe" >> "offline-package\start.bat"
echo pause >> "offline-package\start.bat"

goto :create_readme

:create_package_only
echo 📂 Creating package without executable...
if exist "offline-package" rmdir /s /q "offline-package"
mkdir "offline-package"

REM Copy built files
xcopy "dist" "offline-package\dist\" /E /I /Q
copy "package.json" "offline-package\"

REM Create launcher that uses Node.js
echo @echo off > "offline-package\start.bat"
echo color 0A >> "offline-package\start.bat"
echo echo ========================================== >> "offline-package\start.bat"
echo echo     Transaction Manager - Offline >> "offline-package\start.bat"
echo echo ========================================== >> "offline-package\start.bat"
echo echo. >> "offline-package\start.bat"
echo echo 🚀 Starting Transaction Manager... >> "offline-package\start.bat"
echo echo 🌐 Browser will open automatically >> "offline-package\start.bat"
echo echo 🛑 Close this window to stop >> "offline-package\start.bat"
echo echo. >> "offline-package\start.bat"
echo echo Checking Node.js... >> "offline-package\start.bat"
echo node --version ^>nul 2^>^&1 >> "offline-package\start.bat"
echo if errorlevel 1 ^( >> "offline-package\start.bat"
echo     echo ❌ Node.js required! Download from https://nodejs.org/ >> "offline-package\start.bat"
echo     pause >> "offline-package\start.bat"
echo     exit /b 1 >> "offline-package\start.bat"
echo ^) >> "offline-package\start.bat"
echo timeout /t 2 /nobreak ^>nul >> "offline-package\start.bat"
echo start "" "http://localhost:3000" >> "offline-package\start.bat"
echo echo ✨ Running on http://localhost:3000 >> "offline-package\start.bat"
echo node dist\server\production.mjs >> "offline-package\start.bat"
echo pause >> "offline-package\start.bat"

:create_readme
REM Create README
echo # Transaction Manager - Offline Package > "offline-package\README.txt"
echo. >> "offline-package\README.txt"
echo QUICK START: >> "offline-package\README.txt"
echo 1. Double-click start.bat >> "offline-package\README.txt"
echo 2. Browser opens automatically >> "offline-package\README.txt"
echo 3. Use the Transaction Manager! >> "offline-package\README.txt"
echo. >> "offline-package\README.txt"
if exist "offline-package\transaction-manager.exe" (
    echo INCLUDED: >> "offline-package\README.txt"
    echo - transaction-manager.exe ^(standalone, no Node.js needed^) >> "offline-package\README.txt"
    echo - start.bat ^(one-click launcher^) >> "offline-package\README.txt"
    echo - dist\spa\ ^(web application files^) >> "offline-package\README.txt"
    echo. >> "offline-package\README.txt"
    echo REQUIREMENTS: >> "offline-package\README.txt"
    echo - Windows 10/11 >> "offline-package\README.txt"
    echo - Modern web browser >> "offline-package\README.txt"
    echo - NO other software needed! >> "offline-package\README.txt"
) else (
    echo INCLUDED: >> "offline-package\README.txt"
    echo - dist\server\production.mjs ^(server^) >> "offline-package\README.txt"
    echo - dist\spa\ ^(web application^) >> "offline-package\README.txt"
    echo - start.bat ^(launcher^) >> "offline-package\README.txt"
    echo. >> "offline-package\README.txt"
    echo REQUIREMENTS: >> "offline-package\README.txt"
    echo - Node.js from https://nodejs.org/ >> "offline-package\README.txt"
    echo - Windows 10/11 >> "offline-package\README.txt"
    echo - Modern web browser >> "offline-package\README.txt"
)

echo.
echo ✅ Offline package created!
echo.
echo 📂 Location: offline-package\
echo 📁 Contents:
dir /b "offline-package"
echo.
echo 🧪 TEST: Go to offline-package\ and run start.bat
echo 📦 SHARE: Zip the offline-package\ folder
echo.
echo ==========================================
echo       OFFLINE PACKAGE READY!
echo ==========================================
pause
