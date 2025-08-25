@echo off
echo ==========================================
echo   Transaction Manager - Batch File Creator
echo ==========================================
echo.
echo This will create all run batch files:
echo 1. run-exe.bat     (Executable version)
echo 2. run-dev.bat     (Development server)
echo 3. run-local.bat   (Local static server)
echo.
pause

echo Creating batch files...
echo.

REM Create run-exe.bat
echo Creating run-exe.bat...
(
echo @echo off
echo echo Starting Transaction Manager...
echo echo URL: http://localhost:3000
echo timeout /t 2 /nobreak ^> nul
echo start http://localhost:3000
echo echo.
echo echo Transaction Manager Server Running
echo echo Keep this window open.
echo echo.
echo transaction-manager.exe
) > run-exe.bat

REM Create run-dev.bat
echo Creating run-dev.bat...
(
echo @echo off
echo echo Starting Transaction Manager - Development Mode...
echo echo Checking Node.js and npm...
echo.
echo REM Check if Node.js is installed
echo node --version ^>nul 2^>^&1
echo if %%errorlevel%% neq 0 ^(
echo     echo ERROR: Node.js not found. Please install Node.js first.
echo     pause
echo     exit /b 1
echo ^)
echo.
echo REM Check if npm is installed
echo npm --version ^>nul 2^>^&1
echo if %%errorlevel%% neq 0 ^(
echo     echo ERROR: npm not found. Please install npm first.
echo     pause
echo     exit /b 1
echo ^)
echo.
echo echo Installing dependencies...
echo npm install
echo if %%errorlevel%% neq 0 ^(
echo     echo ERROR: Failed to install dependencies.
echo     pause
echo     exit /b 1
echo ^)
echo.
echo echo URL: http://localhost:7020
echo timeout /t 2 /nobreak ^> nul
echo start http://localhost:7020
echo echo.
echo echo Transaction Manager Development Server Running
echo echo Keep this window open.
echo echo.
echo npm run dev
) > run-dev.bat

REM Create run-local.bat
echo Creating run-local.bat...
(
echo @echo off
echo echo Starting Transaction Manager - Local Server Mode...
echo echo Checking Node.js and npm...
echo.
echo REM Check if Node.js is installed
echo node --version ^>nul 2^>^&1
echo if %%errorlevel%% neq 0 ^(
echo     echo ERROR: Node.js not found. Please install Node.js first.
echo     pause
echo     exit /b 1
echo ^)
echo.
echo REM Check if npm is installed
echo npm --version ^>nul 2^>^&1
echo if %%errorlevel%% neq 0 ^(
echo     echo ERROR: npm not found. Please install npm first.
echo     pause
echo     exit /b 1
echo ^)
echo.
echo echo Installing dependencies...
echo npm install
echo if %%errorlevel%% neq 0 ^(
echo     echo ERROR: Failed to install dependencies.
echo     pause
echo     exit /b 1
echo ^)
echo.
echo echo Building application...
echo npm run build:local
echo if %%errorlevel%% neq 0 ^(
echo     echo ERROR: Failed to build application.
echo     pause
echo     exit /b 1
echo ^)
echo.
echo echo URL: http://localhost:7020
echo timeout /t 2 /nobreak ^> nul
echo start http://localhost:7020
echo echo.
echo echo Transaction Manager Local Server Running
echo echo Keep this window open.
echo echo.
echo npx serve dist/local -p 7020
) > run-local.bat

echo.
echo ✅ SUCCESS: All batch files created!
echo.
echo Files created:
echo - run-exe.bat    (Runs executable - requires transaction-manager.exe)
echo - run-dev.bat    (Runs development server - requires npm/node)
echo - run-local.bat  (Runs local static server - requires npm/node)
echo.
pause
