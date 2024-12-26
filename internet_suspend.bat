REM to get interface names do:
REM netsh interface show interface

netsh interface set interface "Ethernet" admin=disabled
timeout /t 1
cd "C:\Path\To\Exec\Folder"
start "" "program.exe"
timeout /t 1
netsh interface set interface "Ethernet" admin=enabled
