@echo off
echo Starting Transaction Manager Web App...
echo URL: http://localhost:8080/webapp/
timeout /t 2 /nobreak > nul
start http://localhost:8080/webapp/
echo.
echo Transaction Manager Web App Running
echo Keep this window open.
echo.
npx serve . -p 8080
