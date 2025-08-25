@echo off
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

echo.
echo run-exe.bat created successfully!
pause
