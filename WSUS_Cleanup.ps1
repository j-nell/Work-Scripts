net stop wsusservice
cd "C:\Program Files\Update Services\Tools"
wsusutil.exe reset
echo Delete WSUS Folder Content
Remove-Item -path "C:\WSUS\WsusContent\*" -Recurse
pause
net start wsusservice