@echo off
color 0B
echo ==========================================
echo   Batch File Creator for Transaction Manager
echo ==========================================
echo.
echo This will create a run-exe.bat file to run the Transaction Manager executable.
echo.
pause

echo Creating run-exe.bat...
echo.

(
echo @echo off
echo color 0A
echo echo ==========================================
echo echo    Transaction Manager - Executable
echo echo ==========================================
echo echo.
echo echo Welcome! Starting Transaction Manager...
echo echo.
echo.
echo REM Check if executable exists
echo if not exist "transaction-manager.exe" ^(
echo     echo ERROR: transaction-manager.exe not found!
echo     echo Please make sure the executable is in the same folder as this batch file.
echo     echo.
echo     pause
echo     exit /b 1
echo ^)
echo.
echo echo ✅ Executable found
echo echo ✅ Server starting on: http://localhost:3000
echo echo ✅ Browser will open automatically
echo echo.
echo echo 📝 To add transactions: Press 'A' key  
echo echo 💾 To backup data: Go to 'Backup' tab
echo echo 🛑 To stop: Press Ctrl+C in this window or close this window
echo echo.
echo echo ==========================================
echo echo.
echo.
echo REM Start the executable server
echo echo 🚀 Starting Transaction Manager...
echo echo.
echo echo Opening browser in 3 seconds...
echo.
echo REM Start the executable in background
echo start "" "transaction-manager.exe"
echo.
echo REM Wait a moment then open browser
echo timeout /t 3 /nobreak ^>nul
echo start "" "http://localhost:3000"
echo.
echo echo.
echo echo ✨ Transaction Manager is running!
echo echo ✨ Check your browser at: http://localhost:3000
echo echo.
echo echo Press any key to stop the server...
echo pause ^>nul
echo.
echo REM Kill the executable
echo taskkill /f /im "transaction-manager.exe" ^>nul 2^>^&1
echo echo.
echo echo 🛑 Transaction Manager stopped.
echo pause
) > run-exe.bat

echo.
echo ✅ SUCCESS: run-exe.bat has been created!
echo.
echo You can now use run-exe.bat to start the Transaction Manager executable.
echo Make sure transaction-manager.exe is in the same folder.
echo.
echo Files created:
echo - run-exe.bat (runs the executable and opens browser)
echo.
pause
