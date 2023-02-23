$ProgressPreference = 'SilentlyContinue'	

Get-WmiObject -Class win32_useraccount | select name | findstr /v "^$" | ForEach-object { $_.TrimEnd() } | select -Skip 2 > tempusers.txt
wmic useraccount get name | findstr /v "^$" | ForEach-object { $_.TrimEnd() } | select -Skip 1  | Out-File -Encoding ascii tempusers.txt
wmic /NAMESPACE:\\root\directory\ldap PATH ds_user GET ds_samaccountname | findstr /v "^$" | ForEach-object { $_.TrimEnd() } | select -Skip 1 | Out-File -Encoding ascii tempusers.txt
cat tempusers.txt | sort-object| Get-Unique | findstr /v "^$" | Out-File -Encoding ascii users.txt
remove-item tempusers.txt
cat users.txt