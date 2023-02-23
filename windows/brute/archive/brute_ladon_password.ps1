<#
$global:target="192.168.80.50"
$global:domain="INSECURE.local"
$global:userlist="users.txt"
#>

$global:target=$args[0]

function run-ladon {

# add the date at stat and end just for timing 
date 
type users.txt > user.txt

# password 
type pass_password.txt > pass.txt 
.\Ladon.exe $target smbscan
type SmbScan.log

date
echo ""
echo ""
echo "################ FINISHED ################"
echo ""
type SmbScan.log
}

# Run 

if ($target) { 
run-ladon | Tee ladon_brute.txt
} else {
Write-Host "USEAGE: " 
Write-Host "	./cme-brute.ps1 [IP ADDRESS]" 
Write-Host "" 
Write-Host "" 
}



