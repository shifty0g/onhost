$ProgressPreference = 'SilentlyContinue'	
remove-item users.txt
$(net user /domain | select -Skip 6 | findstr /v "The command completed") -Split ' ' | ForEach-object { $_.TrimEnd() } | where{$_ -ne ""}  | Out-File -Encoding ascii users.txt 
cat users.txt