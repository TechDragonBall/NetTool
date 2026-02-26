@echo off
title Network Tool-using Batch
chcp 65001 >nul
goto banner
:banner
echo.
echo.
echo               ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗    ████████╗ ██████╗  ██████╗ ██╗     
echo               ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝    ╚══██╔══╝██╔═══██╗██╔═══██╗██║     
echo               ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝        ██║   ██║   ██║██║   ██║██║     
echo               ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗        ██║   ██║   ██║██║   ██║██║     
echo               ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗       ██║   ╚██████╔╝╚██████╔╝███████╗
echo               ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝       ╚═╝    ╚═════╝  ╚═════╝ ╚══════╝
echo.
echo.
echo Free to use Network Tool
echo which checks for:
echo =======================
echo.
echo.
echo  1) SSID
echo  2) Network Adapter
echo  3) Signal
echo  4) Status
echo  5) Ping
echo  6) Bytes Sent and Received
echo  7) Packet Loss
echo.
echo.
echo Enjoy. :)
echo Loading Network Information...
timeout /t 7 >nul
:loop
for /f "tokens=2 delims=:" %%a in ('netsh wlan show interface^|find "SSID"^| findstr /v "BSSID" ')do set ssid= %%a
for /f "tokens=2 delims=:" %%a in ('netsh wlan show interface^|find "Description"')do set description= %%a
for /f "tokens=2 delims=:" %%a in ('netsh wlan show interface^|find "State"')do set state= %%a
for /f "tokens=2 delims=:" %%a in ('netsh wlan show interface^|find "Signal"')do set signal= %%a
ping -n 3 8.8.8.8>%temp%\ping.txt
for /f "tokens=4 delims==" %%a in ('type %temp%\ping.txt^| find "Average"')do set average= %%a
for /f "tokens=10 delims= " %%a in ('type %temp%\ping.txt^| find "Lost"')do set lost= %%a
for /f "tokens=2 delims= " %%a in ('netstat -e^| find "Bytes"')do set rbytes=%%a
for /f "tokens=3 delims= " %%a in ('netstat -e^| find "Bytes"')do set sbytes=%%a 
cls
echo Network:
echo ---------
echo SSID: %ssid%
echo Description: %description%
echo Status: %state%
echo Signal: %signal%
echo.
echo Speed:
echo ---------
echo Ping: %average%
echo Packet Loss: %lost%
echo Bytes Sent: %sbytes%
echo Bytes Received: %rbytes%
goto loop