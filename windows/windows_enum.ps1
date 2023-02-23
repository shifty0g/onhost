


function tool-header($str){
echo "========================================================================="
echo "[+] $str"
echo "========================================================================="
}

function tool-footer {
echo ""
echo ""
echo ""
echo ""
}


function run-minimal {
tool-header("Systeminfo")
systeminfo
tool-footer

tool-header("whoami /all")
whoami /all
tool-footer

}


function network {
tool-header("ARP")
arp -a 
tool-footer

tool-header("ipconfig /all")
ipconfig /all 
tool-footer

tool-header("route print")
route print
tool-footer

tool-header("netstat")
netstat /n
tool-footer

tool-header("\etc\hosts file")
type C:\windows\System32\drivers\etc\hosts | findstr -v '#'
tool-footer
}


function run-full  {

run-minimal

network





tool-header("net config workstation")
net config workstation
tool-footer


tool-header("net accounts")
net accounts
tool-footer

tool-header("wmic useraccount")
wmic useraccount get /format:list
tool-footer


tool-header("net view")
net view
tool-footer


tool-header("AV")
wmic /namespace:\\root\securitycenter2 path antivirusproduct /Format:List
tool-footer

tool-header("Windows Defender")
Get-Service WinDefend
Get-MpComputerStatus 
Get-MpThreat 
tool-footer


tool-header("Firewall")
netsh firewall show state
netsh firewall show config
netsh firewall show opmode
tool-footer

tool-header("Installed SW - wmic product get Name,Version")
wmic product get Name,Version
tool-footer

tool-header("Local Groups")
net localgroup
tool-footer

tool-header("Administrators - Local Group")
net localgroup "Administrators"
tool-footer

tool-header("Remote Desktop Users - Local Group")
net localgroup "Remote Desktop Users"
tool-footer

tool-header("Users - Local Group")
net localgroup "Users"
tool-footer

tool-header("Patches - wmic qfe")
wmic qfe
tool-footer

tool-header("net share")
net share
tool-footer


tool-header("Tasklist /svc")
Tasklist /svc
tool-footer



}


run-full | Tee C:\windows\temp\winenum.txt


