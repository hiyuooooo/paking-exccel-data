@echo off
setlocal enabledelayedexpansion
color 0F

echo ==========================================
echo   Transaction Manager - Windows Installer
echo ==========================================
echo.
echo This installer will set up Transaction Manager
echo on your Windows computer automatically.
echo.
echo What this installer does:
echo ✓ Checks system requirements
echo ✓ Installs Node.js (if needed)
echo ✓ Installs application dependencies
echo ✓ Creates desktop shortcuts
echo ✓ Tests the installation
echo.

set /p CONTINUE="Do you want to continue? (Y/N): "
if /i not "%CONTINUE%"=="Y" (
    echo Installation cancelled.
    pause
    exit /b 0
)

echo.
echo ==========================================
echo      STEP 1: System Requirements Check
echo ==========================================
echo.

REM Check Windows version
echo 🔍 Checking Windows version...
for /f "tokens=4-5 delims=. " %%i in ('ver') do set VERSION=%%i.%%j
echo ✅ Windows version: %VERSION%

REM Check if running as administrator
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo ⚠️  NOTICE: Not running as Administrator
    echo Some features may require Administrator privileges.
    echo.
) else (
    echo ✅ Running with Administrator privileges
)

echo.
echo ==========================================
echo        STEP 2: Node.js Installation
echo ==========================================
echo.

REM Check if Node.js is installed
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Node.js not found
    echo.
    echo Transaction Manager requires Node.js to run.
    echo.
    echo Options:
    echo 1. Download and install Node.js from https://nodejs.org/
    echo 2. Use the packaged executable version (no Node.js required)
    echo.
    echo Would you like to:
    echo A. Open Node.js download page in browser
    echo B. Continue without Node.js (manual install later)
    echo C. Exit installer
    echo.
    set /p NODEJS_CHOICE="Enter your choice (A/B/C): "
    
    if /i "!NODEJS_CHOICE!"=="A" (
        echo Opening Node.js download page...
        start "" "https://nodejs.org/en/download/"
        echo.
        echo Please install Node.js and run this installer again.
        echo.
        pause
        exit /b 1
    )
    
    if /i "!NODEJS_CHOICE!"=="B" (
        echo Continuing without Node.js...
        echo You'll need to install Node.js manually later.
        set NODEJS_INSTALLED=false
    ) else (
        echo Installation cancelled.
        pause
        exit /b 0
    )
) else (
    echo ✅ Node.js is installed
    node --version
    set NODEJS_INSTALLED=true
)

echo.
echo ==========================================
echo      STEP 3: Package Manager Setup
echo ==========================================
echo.

if "!NODEJS_INSTALLED!"=="true" (
    REM Check for pnpm, install if needed
    pnpm --version >nul 2>&1
    if !errorlevel! neq 0 (
        echo 📦 Installing PNPM package manager...
        npm install -g pnpm
        if !errorlevel! neq 0 (
            echo ⚠️  PNPM installation failed, will use npm instead
            set PKG_MANAGER=npm
        ) else (
            echo ✅ PNPM installed successfully
            set PKG_MANAGER=pnpm
        )
    ) else (
        echo ✅ PNPM is already installed
        set PKG_MANAGER=pnpm
    )
    
    echo Package manager: !PKG_MANAGER!
    !PKG_MANAGER! --version
) else (
    echo ⏭️  Skipping package manager setup (Node.js not available)
)

echo.
echo ==========================================
echo    STEP 4: Application Dependencies
echo ==========================================
echo.

if "!NODEJS_INSTALLED!"=="true" (
    if exist "package.json" (
        echo 📦 Installing application dependencies...
        echo This may take 2-5 minutes...
        echo.
        !PKG_MANAGER! install
        if !errorlevel! neq 0 (
            echo ❌ Failed to install dependencies
            echo.
            echo Please check your internet connection and try again.
            echo You can also try running: npm install
            echo.
            pause
            exit /b 1
        )
        echo ✅ Dependencies installed successfully
    ) else (
        echo ❌ package.json not found
        echo Make sure you're running this installer from the project folder.
        pause
        exit /b 1
    )
) else (
    echo ⏭️  Skipping dependency installation (Node.js not available)
)

echo.
echo ==========================================
echo        STEP 5: Desktop Shortcuts
echo ==========================================
echo.

set /p CREATE_SHORTCUTS="Create desktop shortcuts? (Y/N): "
if /i "!CREATE_SHORTCUTS!"=="Y" (
    echo 🔗 Creating desktop shortcuts...
    
    REM Create shortcut to run.bat
    set DESKTOP=%USERPROFILE%\Desktop
    set CURRENT_DIR=%cd%
    
    REM Create VBS script to create shortcut
    echo Set oWS = WScript.CreateObject("WScript.Shell") > CreateShortcut.vbs
    echo sLinkFile = "!DESKTOP!\Transaction Manager.lnk" >> CreateShortcut.vbs
    echo Set oLink = oWS.CreateShortcut(sLinkFile) >> CreateShortcut.vbs
    echo oLink.TargetPath = "!CURRENT_DIR!\run.bat" >> CreateShortcut.vbs
    echo oLink.WorkingDirectory = "!CURRENT_DIR!" >> CreateShortcut.vbs
    echo oLink.Description = "Transaction Manager - Local Server" >> CreateShortcut.vbs
    echo oLink.Save >> CreateShortcut.vbs
    
    cscript CreateShortcut.vbs >nul
    del CreateShortcut.vbs
    
    if exist "!DESKTOP!\Transaction Manager.lnk" (
        echo ✅ Desktop shortcut created successfully
    ) else (
        echo ⚠️  Could not create desktop shortcut
    )
) else (
    echo ⏭️  Skipping desktop shortcuts
)

echo.
echo ==========================================
echo         STEP 6: Installation Test
echo ==========================================
echo.

if "!NODEJS_INSTALLED!"=="true" (
    set /p TEST_INSTALL="Test the installation now? (Y/N): "
    if /i "!TEST_INSTALL!"=="Y" (
        echo 🧪 Testing installation...
        echo.
        echo Starting development server for testing...
        echo Press Ctrl+C to stop the test when browser opens.
        echo.
        timeout /t 3 /nobreak >nul
        
        REM Try to start the dev server briefly
        start /min cmd /c "!PKG_MANAGER! run dev"
        timeout /t 5 /nobreak >nul
        
        REM Open browser to test
        start "" "http://localhost:7020"
        
        echo.
        echo ✅ Test completed
        echo Browser should have opened to http://localhost:7020
        echo.
        echo If you see the Transaction Manager interface, installation was successful!
        echo.
    )
) else (
    echo ⏭️  Skipping installation test (Node.js not available)
)

echo.
echo ==========================================
echo         INSTALLATION COMPLETE! 
echo ==========================================
echo.

if "!NODEJS_INSTALLED!"=="true" (
    echo ✅ Transaction Manager is ready to use!
    echo.
    echo 🚀 To start the application:
    echo    • Double-click the desktop shortcut, or
    echo    • Double-click run.bat in this folder, or
    echo    • Run: !PKG_MANAGER! dev
    echo.
    echo 🌐 Application URL: http://localhost:7020
    echo 📖 User Guide: WINDOWS-DEPLOYMENT-GUIDE.md
    echo 🔧 Technical Guide: LOCAL_DEPLOYMENT.md
) else (
    echo ⚠️  Installation completed with Node.js missing
    echo.
    echo Next steps:
    echo 1. Install Node.js from https://nodejs.org/
    echo 2. Run this installer again, or
    echo 3. Use the packaged executable version
    echo.
    echo 📖 Full Guide: WINDOWS-DEPLOYMENT-GUIDE.md
)

echo.
echo 🎉 Thank you for installing Transaction Manager!
echo.

set /p OPEN_GUIDE="Open the user guide now? (Y/N): "
if /i "!OPEN_GUIDE!"=="Y" (
    if exist "WINDOWS-DEPLOYMENT-GUIDE.md" (
        start "" "WINDOWS-DEPLOYMENT-GUIDE.md"
    ) else (
        start "" "LOCAL_DEPLOYMENT.md"
    )
)

echo.
pause

endlocal
