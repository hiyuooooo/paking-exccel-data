@echo off
echo Starting Transaction Manager...
echo URL: http://localhost:3000
timeout /t 2 /nobreak > nul
start http://localhost:3000
echo.
echo Transaction Manager Server Running
echo Keep this window open.
echo.
transaction-manager.exe
