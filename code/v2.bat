@echo off
ssh -o StrictHostKeyChecking=no -R 0:PRIVATE:PORT  TOKEN@v2.i996.me -p 8222
set /a left=0
set /a right=2
:1
ping 127.0.0.1 -n 3  >nul 
if %right% lss %left% goto 1
echo. & pause
