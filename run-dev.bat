@echo off
echo Starting Transaction Manager - Development Mode...
echo Checking Node.js and npm...

REM Check if Node.js is installed
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Node.js not found. Please install Node.js first.
    pause
    exit /b 1
)

REM Check if npm is installed
npm --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: npm not found. Please install npm first.
    pause
    exit /b 1
)

echo Installing dependencies...
npm install
if %errorlevel% neq 0 (
    echo ERROR: Failed to install dependencies.
    pause
    exit /b 1
)

echo URL: http://localhost:7020
timeout /t 2 /nobreak > nul
start http://localhost:7020
echo.
echo Transaction Manager Development Server Running
echo Keep this window open.
echo.
npm run dev
