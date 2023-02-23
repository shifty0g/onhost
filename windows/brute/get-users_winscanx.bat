@echo off 
echo %1 


if not "%1" == "" (
	WinScanX.exe -r %1 | findstr "Username"
) else (
    echo run with IP
)