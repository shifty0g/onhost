$ProgressPreference = 'SilentlyContinue'	

$global:target=$args[0]


function run-winscanx {
$(.\WinScanX.exe -r $TARGET | findstr Username | findstr /v \$) -split '\\' | findstr /v Username | Select-String -NotMatch -Pattern " " |  Out-File -Encoding ascii users.txt 
(gc users.txt) | Foreach {$_.TrimEnd()} | where {$_ -ne ""} | Set-Content users.txt
cat users.txt 
Remove-Item -Force Reports -ErrorAction SilentlyContinue -Recurse -Confirm:$false
Remove-Item -Force UserCache -ErrorAction SilentlyContinue -Recurse -Confirm:$false
}


if ($target) { 
run-winscanx
} else {
Write-Host "USEAGE: " 
Write-Host "	./get-users_winscanx [IP ADDRESS]" 
Write-Host "" 
Write-Host "" 
}

