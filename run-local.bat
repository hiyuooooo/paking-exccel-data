@echo off
echo Starting Transaction Manager - Local Server Mode...

REM Check if Node.js is installed
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Node.js not found. Please install Node.js first.
    echo Download from: https://nodejs.org/
    pause
    exit /b 1
)

echo Node.js found. Installing dependencies...
npm install
if %errorlevel% neq 0 (
    echo ERROR: Failed to install dependencies.
    pause
    exit /b 1
)

echo Building local version...
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
npm run start:local
