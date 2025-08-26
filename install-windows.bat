@echo off
color 0F
echo ==========================================
echo   Transaction Manager - Setup
echo ==========================================
echo.
echo This will help you set up Transaction Manager.
echo.

REM Check if Node.js is installed
echo 🔍 Checking requirements...
node --version >nul 2>&1
if errorlevel 1 (
    echo.
    echo ❌ Node.js is required but not found
    echo.
    echo Please install Node.js first:
    echo 1. Go to https://nodejs.org/
    echo 2. Download and install Node.js
    echo 3. Restart your computer
    echo 4. Run this installer again
    echo.
    set /p OPEN_NODEJS="Open Node.js website now? (Y/N): "
    if /i "%OPEN_NODEJS%"=="Y" (
        start "" "https://nodejs.org/"
    )
    echo.
    pause
    exit /b 1
)

echo ✅ Node.js found:
node --version
echo.

REM Check if we're in the right directory
if not exist "package.json" (
    echo ❌ package.json not found
    echo Make sure you're running this from the project folder
    pause
    exit /b 1
)

echo ✅ Project files found
echo.

REM Install dependencies
echo 📦 Installing dependencies...
echo This may take 2-5 minutes...
echo.

REM Try pnpm first, then npm
pnpm --version >nul 2>&1
if errorlevel 1 (
    echo Using npm...
    npm install
) else (
    echo Using pnpm...
    pnpm install
)

if errorlevel 1 (
    echo.
    echo ❌ Installation failed
    echo.
    echo Try:
    echo 1. Check your internet connection
    echo 2. Run as Administrator
    echo 3. Delete node_modules folder and try again
    echo.
    pause
    exit /b 1
)

echo.
echo ✅ Installation completed!
echo.

REM Offer to create desktop shortcut
set /p CREATE_SHORTCUT="Create desktop shortcut? (Y/N): "
if /i "%CREATE_SHORTCUT%"=="Y" (
    echo 🔗 Creating shortcut...
    
    REM Simple shortcut creation using PowerShell
    powershell -Command "$WshShell = New-Object -comObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut('%USERPROFILE%\Desktop\Transaction Manager.lnk'); $Shortcut.TargetPath = '%cd%\run.bat'; $Shortcut.WorkingDirectory = '%cd%'; $Shortcut.Description = 'Transaction Manager'; $Shortcut.Save()"
    
    if exist "%USERPROFILE%\Desktop\Transaction Manager.lnk" (
        echo ✅ Desktop shortcut created
    ) else (
        echo ⚠️ Could not create shortcut
    )
)

echo.
echo ==========================================
echo         SETUP COMPLETE!
echo ==========================================
echo.
echo ✅ Transaction Manager is ready!
echo.
echo 🚀 To start:
echo    • Double-click run.bat, or
echo    • Use the desktop shortcut, or
echo    • Run: pnpm dev
echo.
echo 🌐 App will open at: http://localhost:7020
echo.

set /p START_NOW="Start Transaction Manager now? (Y/N): "
if /i "%START_NOW%"=="Y" (
    echo.
    echo 🚀 Starting...
    call run.bat
) else (
    echo.
    echo Ready to use! Run run.bat when you want to start.
    pause
)
