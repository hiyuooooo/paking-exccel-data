@echo off
echo Starting Transaction Manager - Local Server Mode...
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

echo Building application...
npm run build:local
if %errorlevel% neq 0 (
    echo ERROR: Failed to build application.
    pause
    exit /b 1
)

echo URL: http://localhost:7020
timeout /t 2 /nobreak > nul
start http://localhost:7020
echo.
echo Transaction Manager Local Server Running
echo Keep this window open.
echo.
npx serve dist/local -p 7020
