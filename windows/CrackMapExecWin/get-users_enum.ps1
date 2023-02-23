$ProgressPreference = 'SilentlyContinue'	

$global:target=$args[0]


function run-enum {

$(.\enum.exe -U $TARGET | Select-String -NotMatch -Pattern "server: ", "setting up session", "getting user list", "cleaning up") -Split " " | Where { $_.Replace(";","")} | Out-File -Encoding ascii users.txt 
(gc users.txt) | Foreach {$_.TrimEnd()} | where {$_ -ne ""} | Set-Content users.txt
cat users.txt 
}


if ($target) { 
run-enum
} else {
Write-Host "USEAGE: " 
Write-Host "	./get-users_enum [IP ADDRESS]" 
Write-Host "" 
Write-Host "" 
}




