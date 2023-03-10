@echo off

set long=no

echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-^> [*] BASIC SYSTEM INFO ^<_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-^> [+] WINDOWS OS ^<_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
echo [i] Check for vulnerabilities for the OS version with the applied patches
systeminfo
echo.
wmic qfe get Caption,Description,HotFixID,InstalledOn | more
echo.
echo.
set expl=no
for /f "tokens=3-9" %%a in ('systeminfo') do (echo "%%a %%b %%c %%d %%e %%f %%g" | findstr /i "2000 XP 2003 2008 vista" && set expl=yes) & (echo "%%a %%b %%c %%d %%e %%f %%g" | findstr /i /C:"windows 7" && set expl=yes)
IF "%expl%" == "yes" echo [i] Possible exploits (https://github.com/codingo/OSCP-2/blob/master/Windows/WinPrivCheck.bat)
IF "%expl%" == "yes" wmic qfe get Caption,Description,HotFixID,InstalledOn | findstr /C:"KB2592799" 1>NUL
IF "%expl%" == "yes" IF errorlevel 1 echo MS11-080 patch is NOT installed! (Vulns: XP/SP3,2K3/SP3-afd.sys)
IF "%expl%" == "yes" wmic qfe get Caption,Description,HotFixID,InstalledOn | findstr /C:"KB3143141" 1>NUL
IF "%expl%" == "yes" IF errorlevel 1 echo MS16-032 patch is NOT installed! (Vulns: 2K8/SP1/2,Vista/SP2,7/SP1-secondary logon)
IF "%expl%" == "yes" wmic qfe get Caption,Description,HotFixID,InstalledOn | findstr /C:"KB2393802" 1>NUL
IF "%expl%" == "yes" IF errorlevel 1 echo MS11-011 patch is NOT installed! (Vulns: XP/SP2/3,2K3/SP2,2K8/SP2,Vista/SP1/2,7/SP0-WmiTraceMessageVa)
IF "%expl%" == "yes" wmic qfe get Caption,Description,HotFixID,InstalledOn | findstr /C:"KB982799" 1>NUL
IF "%expl%" == "yes" IF errorlevel 1 echo MS10-59 patch is NOT installed! (Vulns: 2K8,Vista,7/SP0-Chimichurri)
IF "%expl%" == "yes" wmic qfe get Caption,Description,HotFixID,InstalledOn | findstr /C:"KB979683" 1>NUL
IF "%expl%" == "yes" IF errorlevel 1 echo MS10-21 patch is NOT installed! (Vulns: 2K/SP4,XP/SP2/3,2K3/SP2,2K8/SP2,Vista/SP0/1/2,7/SP0-Win Kernel)
IF "%expl%" == "yes" wmic qfe get Caption,Description,HotFixID,InstalledOn | findstr /C:"KB2305420" 1>NUL
IF "%expl%" == "yes" IF errorlevel 1 echo MS10-092 patch is NOT installed! (Vulns: 2K8/SP0/1/2,Vista/SP1/2,7/SP0-Task Sched)
IF "%expl%" == "yes" wmic qfe get Caption,Description,HotFixID,InstalledOn | findstr /C:"KB981957" 1>NUL
IF "%expl%" == "yes" IF errorlevel 1 echo MS10-073 patch is NOT installed! (Vulns: XP/SP2/3,2K3/SP2/2K8/SP2,Vista/SP1/2,7/SP0-Keyboard Layout)
IF "%expl%" == "yes" wmic qfe get Caption,Description,HotFixID,InstalledOn | findstr /C:"KB4013081" 1>NUL
IF "%expl%" == "yes" IF errorlevel 1 echo MS17-017 patch is NOT installed! (Vulns: 2K8/SP2,Vista/SP2,7/SP1-Registry Hive Loading)
IF "%expl%" == "yes" wmic qfe get Caption,Description,HotFixID,InstalledOn | findstr /C:"KB977165" 1>NUL
IF "%expl%" == "yes" IF errorlevel 1 echo MS10-015 patch is NOT installed! (Vulns: 2K,XP,2K3,2K8,Vista,7-User Mode to Ring)
IF "%expl%" == "yes" wmic qfe get Caption,Description,HotFixID,InstalledOn | findstr /C:"KB941693" 1>NUL
IF "%expl%" == "yes" IF errorlevel 1 echo MS08-025 patch is NOT installed! (Vulns: 2K/SP4,XP/SP2,2K3/SP1/2,2K8/SP0,Vista/SP0/1-win32k.sys)
IF "%expl%" == "yes" wmic qfe get Caption,Description,HotFixID,InstalledOn | findstr /C:"KB920958" 1>NUL
IF "%expl%" == "yes" IF errorlevel 1 echo MS06-049 patch is NOT installed! (Vulns: 2K/SP4-ZwQuerySysInfo)
IF "%expl%" == "yes" wmic qfe get Caption,Description,HotFixID,InstalledOn | findstr /C:"KB914389" 1>NUL
IF "%expl%" == "yes" IF errorlevel 1 echo MS06-030 patch is NOT installed! (Vulns: 2K,XP/SP2-Mrxsmb.sys)
IF "%expl%" == "yes" wmic qfe get Caption,Description,HotFixID,InstalledOn | findstr /C:"KB908523" 1>NUL
IF "%expl%" == "yes" IF errorlevel 1 echo MS05-055 patch is NOT installed! (Vulns: 2K/SP4-APC Data-Free)
IF "%expl%" == "yes" wmic qfe get Caption,Description,HotFixID,InstalledOn | findstr /C:"KB890859" 1>NUL
IF "%expl%" == "yes" IF errorlevel 1 echo MS05-018 patch is NOT installed! (Vulns: 2K/SP3/4,XP/SP1/2-CSRSS)
IF "%expl%" == "yes" wmic qfe get Caption,Description,HotFixID,InstalledOn | findstr /C:"KB842526" 1>NUL
IF "%expl%" == "yes" IF errorlevel 1 echo MS04-019 patch is NOT installed! (Vulns: 2K/SP2/3/4-Utility Manager)
IF "%expl%" == "yes" wmic qfe get Caption,Description,HotFixID,InstalledOn | findstr /C:"KB835732" 1>NUL
IF "%expl%" == "yes" IF errorlevel 1 echo MS04-011 patch is NOT installed! (Vulns: 2K/SP2/3/4,XP/SP0/1-LSASS service BoF)
IF "%expl%" == "yes" wmic qfe get Caption,Description,HotFixID,InstalledOn | findstr /C:"KB841872" 1>NUL
IF "%expl%" == "yes" IF errorlevel 1 echo MS04-020 patch is NOT installed! (Vulns: 2K/SP4-POSIX)
IF "%expl%" == "yes" wmic qfe get Caption,Description,HotFixID,InstalledOn | findstr /C:"KB2975684" 1>NUL
IF "%expl%" == "yes" IF errorlevel 1 echo MS14-040 patch is NOT installed! (Vulns: 2K3/SP2,2K8/SP2,Vista/SP2,7/SP1-afd.sys Dangling Pointer)
IF "%expl%" == "yes" wmic qfe get Caption,Description,HotFixID,InstalledOn | findstr /C:"KB3136041" 1>NUL
IF "%expl%" == "yes" IF errorlevel 1 echo MS16-016 patch is NOT installed! (Vulns: 2K8/SP1/2,Vista/SP2,7/SP1-WebDAV to Address)
IF "%expl%" == "yes" wmic qfe get Caption,Description,HotFixID,InstalledOn | findstr /C:"KB3057191" 1>NUL
IF "%expl%" == "yes" IF errorlevel 1 echo MS15-051 patch is NOT installed! (Vulns: 2K3/SP2,2K8/SP2,Vista/SP2,7/SP1-win32k.sys)
IF "%expl%" == "yes" wmic qfe get Caption,Description,HotFixID,InstalledOn | findstr /C:"KB2989935" 1>NUL
IF "%expl%" == "yes" IF errorlevel 1 echo MS14-070 patch is NOT installed! (Vulns: 2K3/SP2-TCP/IP)
IF "%expl%" == "yes" wmic qfe get Caption,Description,HotFixID,InstalledOn | findstr /C:"KB2778930" 1>NUL
IF "%expl%" == "yes" IF errorlevel 1 echo MS13-005 patch is NOT installed! (Vulns: Vista,7,8,2008,2008R2,2012,RT-hwnd_broadcast)
IF "%expl%" == "yes" wmic qfe get Caption,Description,HotFixID,InstalledOn | findstr /C:"KB2850851" 1>NUL
IF "%expl%" == "yes" IF errorlevel 1 echo MS13-053 patch is NOT installed! (Vulns: 7SP0/SP1_x86-schlamperei)
IF "%expl%" == "yes" wmic qfe get Caption,Description,HotFixID,InstalledOn | findstr /C:"KB2870008" 1>NUL
IF "%expl%" == "yes" IF errorlevel 1 echo MS13-081 patch is NOT installed! (Vulns: 7SP0/SP1_x86-track_popup_menu)
echo.
echo.
echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-^> [+] DATE and TIME ^<_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
echo [i] You may need to adjust your local date/time to exploit some vulnerability
date /T
time /T
echo.
echo.
echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-^> [+] UAC? ^<_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
echo [i] If the results read ENABLELUA REG_DWORD 0x1, part or all of the UAC components are on
REG QUERY HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\ /v EnableLUA
echo.
echo.
echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-^> [+] Registered Anti-Virus(AV) ^<_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
WMIC /Node:localhost /Namespace:\\root\SecurityCenter2 Path AntiVirusProduct Get displayName /Format:List | more 
echo.
echo.
echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-^> [+] MOUNTED DISKS ^<_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
echo [i] Maybe you find something interesting
(wmic logicaldisk get caption 2>nul | more) || (fsutil fsinfo drives 2>nul)
echo.
echo.
echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-^> [+] ENVIRONMENT ^<_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
echo [i] Interesting information?
set
echo.
echo.
echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-^> [+] INSTALLED SOFTWARE ^<_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
echo [i] Some weird software? Check for vulnerabilities in unknow software installed
::wmic product get name | more  TOO MUCH OUTPUT
dir /b "C:\Program Files" "C:\Program Files (x86)" | sort
reg query HKEY_LOCAL_MACHINE\SOFTWARE
IF exist C:\Windows\CCM\SCClient.exe echo SCCM is installed (installers are run with SYSTEM privileges, many are vulnerable to DLL Sideloading)
echo.
echo.
echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-^> [+] WSUS ^<_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
echo [i] You can inject 'fake' updates into non-SSL WSUS traffic (WSUXploit)
reg query HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\WindowsUpdate\ 2>nul | findstr /i "wuserver" | findstr /i "http://"
echo.
echo.
echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-^> [+] RUNNING PROCESSES ^<_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
echo [i] Something unexpected is running? Check for vulnerabilities
tasklist /SVC
echo.
echo [i] Checking file permissions of running processes (File backdooring - maybe the same files start automatically when Administrator logs in)
for /f "tokens=2 delims='='" %%x in ('wmic process list full^|find /i "executablepath"^|find /i /v "system32"^|find ":"') do (
	for /f eol^=^"^ delims^=^" %%z in ('echo %%x') do (
		icacls "%%z" 2>nul | findstr /i "(F) (M) (W) :\\" | findstr /i ":\\ everyone authenticated users todos %username%" && echo.
	)
)
echo.
echo [i] Checking directory permissions of running processes (DLL injection)
for /f "tokens=2 delims='='" %%x in ('wmic process list full^|find /i "executablepath"^|find /i /v "system32"^|find ":"') do for /f eol^=^"^ delims^=^" %%y in ('echo %%x') do (
	icacls "%%~dpy\" 2>nul | findstr /i "(F) (M) (W) :\\" | findstr /i ":\\ everyone authenticated users todos %username%" && echo.
)
echo.
echo.
echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-^> [+] RUN ^AT STARTUP ^<_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
echo [i] Check if you can modify any binary that is going to be executed by admin or if you can impersonate a not found binary
(autorunsc.exe -m -nobanner -a * -ct /accepteula 2>nul || wmic startup get caption,command 2>nul | more & ^
reg query HKLM\Software\Microsoft\Windows\CurrentVersion\Run 2>nul & ^
reg query HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnce 2>nul & ^
reg query HKCU\Software\Microsoft\Windows\CurrentVersion\Run 2>nul & ^
reg query HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce 2>nul & ^
icacls "C:\Documents and Settings\All Users\Start Menu\Programs\Startup" 2>nul | findstr /i "(F) (M) (W) :\" | findstr /i ":\\ everyone authenticated users todos %username%" && echo. & ^
icacls "C:\Documents and Settings\All Users\Start Menu\Programs\Startup\*" 2>nul | findstr /i "(F) (M) (W) :\" | findstr /i ":\\ everyone authenticated users todos %username%" && echo. & ^
icacls "C:\Documents and Settings\%username%\Start Menu\Programs\Startup" 2>nul | findstr /i "(F) (M) (W) :\" | findstr /i ":\\ everyone authenticated users todos %username%" && echo. & ^
icacls "C:\Documents and Settings\%username%\Start Menu\Programs\Startup\*" 2>nul | findstr /i "(F) (M) (W) :\" | findstr /i ":\\ everyone authenticated users todos %username%" && echo. & ^
icacls "%programdata%\Microsoft\Windows\Start Menu\Programs\Startup" 2>nul | findstr /i "(F) (M) (W) :\" | findstr /i ":\\ everyone authenticated users todos %username%" && echo. & ^
icacls "%programdata%\Microsoft\Windows\Start Menu\Programs\Startup\*" 2>nul | findstr /i "(F) (M) (W) :\" | findstr /i ":\\ everyone authenticated users todos %username%" && echo. & ^
icacls "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup" 2>nul | findstr /i "(F) (M) (W) :\" | findstr /i ":\\ everyone authenticated users todos %username%" && echo. & ^
icacls "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\*" 2>nul | findstr /i "(F) (M) (W) :\" | findstr /i ":\\ everyone authenticated users todos %username%" && echo. & ^
schtasks /query /fo TABLE /nh | findstr /v /i "disable deshab informa")
echo.
echo.
echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-^> [+] AlwaysInstallElevated? ^<_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
echo [i] If '1' then you can install a .msi file with admin privileges ;)
reg query HKCU\SOFTWARE\Policies\Microsoft\Windows\Installer /v AlwaysInstallElevated 2> nul
reg query HKLM\SOFTWARE\Policies\Microsoft\Windows\Installer /v AlwaysInstallElevated 2> nul
echo.
echo.
echo.
echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-^> [*] NETWORK ^<_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
echo.
echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-^> [+] CURRENT SHARES ^<_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
net share
echo.
echo.
echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-^> [+] INTERFACES ^<_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
ipconfig  /all
echo.
echo.
echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-^> [+] USED PORTS ^<_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
netstat -ano
echo.
echo.
echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-^> [+] FIREWALL ^<_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
netsh firewall show state
netsh firewall show config
echo.
echo.
echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-^> [+] ^ARP ^<_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
arp -A
echo.
echo.
echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-^> [+] ROUTES ^<_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
route print
echo.
echo.
echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-^> [+] HOSTS ^<_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
type C:\WINDOWS\System32\drivers\etc\hosts
echo.
echo.
echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-^> [+] CACHE DNS ^<_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
ipconfig /displaydns | findstr "Record" | findstr "Name Host"
echo.
echo.
echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-^> [+] WIFI ^<_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
echo [i] To get clear-text password use: netsh wlan show profile <SSID> key=clear
netsh wlan show profile
echo.
echo.
echo.
echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-^>[*] BASIC USER INFO ^<_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
echo [i] Check if you are inside the Administrators froup or if you have enabled any token that can be use to escalate privileges like SeImpersonatePrivilege, SeAssignPrimaryPrivilege, SeTcbPrivilege, SeBackupPrivilege, SeRestorePrivilege, SeCreateTokenPrivilege, SeLoadDriverPrivilege, SeTakeOwnershipPrivilege, SeDebbugPrivilege
echo.
echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-^> [+] CURRENT USER ^<_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
net user %username%
net user %USERNAME% /domain 2>nul
whoami /all
echo.
echo.
echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-^> [+] USERS ^<_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
net user
echo.
echo.
echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-^> [+] GROUPS ^<_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
net localgroup
echo.
echo.
echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-^> [+] ADMINISTRATORS GROUPS ^<_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
net localgroup Administrators 2>nul
net localgroup Administradores 2>nul
echo. 
echo.
echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-^> [+] CURRENT LOGGED USERS ^<_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
quser
echo.
echo.
echo.
echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-^> [*] SERVICES VULNERABILITIES ^<_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
echo.
echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-^> [+] SERVICE PERMISSIONS WITH accesschk.exe FOR 'Authenticated users', Everyone, BUILTIN\Users, Todos and CURRENT USER ^<_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
echo [i] If Authenticated Users have SERVICE_ALL_ACCESS or SERVICE_CHANGE_CONFIG or WRITE_DAC or WRITE_OWNER or GENERIC_WRITE or GENERIC_ALL, you can modify the binary that is going to be executed by the service and start/stop the service
echo [i] If accesschk.exe is not in PATH, nothing will be found here
echo [I] AUTHETICATED USERS
accesschk.exe -uwcqv "Authenticated Users" * /accepteula 2>nul
echo [I] EVERYONE
accesschk.exe -uwcqv "Everyone" * /accepteula 2>nul
echo [I] BUILTIN\Users
accesschk.exe -uwcqv "BUILTIN\Users" * /accepteula 2>nul
echo [I] TODOS
accesschk.exe -uwcqv "Todos" * /accepteula 2>nul
echo [I] %USERNAME%
accesschk.exe -uwcqv %username% * /accepteula 2>nul
::echo.
::echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-^> [+] SERVICE PERMISSIONS WITH accesschk.exe FOR * ^<_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
::echo [i] Check for weird service permissions for unexpected groups"
::accesschk.exe -uwcqv * /accepteula 2>nul

echo.
echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-^> [+] SERVICE BINARY PERMISSIONS WITH WMIC + ICACLS ^<_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
for /f "tokens=2 delims='='" %%a in ('cmd.exe /c wmic service list full ^| findstr /i "pathname" ^|findstr /i /v "system32"') do (
    for /f eol^=^"^ delims^=^" %%b in ("%%a") do icacls "%%b" 2>nul | findstr /i "(F) (M) (W) :\\" | findstr /i ":\\ everyone authenticated users todos usuarios %username%" && echo.
)
echo.
echo.
echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-^> [+] CHECK IF YOU CAN MODIFY ANY SERVICE REGISTRY ^<_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
for /f %%a in ('reg query hklm\system\currentcontrolset\services') do del %temp%\reg.hiv >nul 2>&1 & reg save %%a %temp%\reg.hiv >nul 2>&1 && reg restore %%a %temp%\reg.hiv >nul 2>&1 && echo You can modify %%a
echo.
echo.
echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-^> [+] UNQUOTED SERVICE PATHS ^<_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
echo [i] When the path is not quoted (ex: C:\Program files\soft\new folder\exec.exe) Windows will try to execute first 'C:\Progam.exe', then 'C:\Program Files\soft\new.exe' and finally 'C:\Program Files\soft\new folder\exec.exe'. Try to create 'C:\Program Files\soft\new.exe'
echo [i] The permissions are also checked and filtered using icacls
for /f "tokens=2" %%n in ('sc query state^= all^| findstr SERVICE_NAME') do (
	for /f "delims=: tokens=1*" %%r in ('sc qc "%%~n" ^| findstr BINARY_PATH_NAME ^| findstr /i /v /l /c:"c:\windows\system32" ^| findstr /v /c:""""') do (
		echo %%~s | findstr /r /c:"[a-Z][ ][a-Z]" >nul 2>&1 && (echo %%n && echo %%~s && icacls %%s | findstr /i "(F) (M) (W) :\" | findstr /i ":\\ everyone authenticated users todos %username%") && echo.
	)
)
::wmic service get name,displayname,pathname,startmode | more | findstr /i /v "C:\\Windows\\system32\\" | findstr /i /v """
echo.
echo.
echo.
echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-^> [*] INTERESTING WRITABLE FILES ^<_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
echo [i] Maybe you can take advantage of modifying/creating some binary in some of the following locations
echo [i] PATH variable entries permissions - place binary or DLL to execute instead of legitimate
for %%A in ("%path:;=";"%") do ( cmd.exe /c icacls "%%~A" 2>nul | findstr /i "(F) (M) (W) :\" | findstr /i ":\\ everyone authenticated users todos %username%" && echo. )
echo.
echo.
echo.
echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-^> [*] CREDENTIALS ^<_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-^> [+] SAVED CREDENTIALS ^<_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
cmdkey /list
echo Looking inside %appdata%\Microsoft\Credentials\
dir /b %appdata%\Microsoft\Credentials\ 2>nul 
echo Looking inside %localappdata%\Microsoft\Credentials\
dir /b %localappdata%\Microsoft\Credentials\ 2>nul
echo.
echo.
echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-^> [+] Files that may contain credentials ^<_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
echo [i] Searching specific files that may contains credentias. The password could be in clear text, Base64 or cPassword (use gpp-decrypt)
cd ..\..\..\..\..\..\..\..\..\..\..\..\..\..\..\..\..\..\..
dir /s/b /A -D FreeSSHDservice.ini == sysprep.inf == sysprep.xml == unattend.xml == unattended.xml == *vnc* == groups.xml == services.xml == scheduledtasks.xml == printers.xml == drives.xml == datasources.xml == php.ini == https.conf == https-xampp.conf == httpd.conf == my.ini == my.cnf == access.log == error.log == server.xml == SiteList.xml == ConsoleHost_history.txt == setupinfo == setupinfo.bak 2>nul
cd inetpub 2>nul && (dir /s/b web.config == *.log & cd ..)
reg query HKCU\Software\ORL\WinVNC3\Password 2>nul
reg query HKEY_LOCAL_MACHINE\SOFTWARE\RealVNC\WinVNC4 /v password 2>NUL
reg query HKLM\SYSTEM\Microsoft\Windows NT\Currentversion\WinLogon 2>nul
reg query HKLM\SYSTEM\CurrentControlSet\Services\SNMP /s 2>nul
reg query HKCU\Software\TightVNC\Server 2>nul
reg query HKCU\Software\SimonTatham\PuTTY\Sessions /s 2>nul
echo.
echo.

if "%long%" == "yes" (
    echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-^> [+] REGISTRY WITH STRING pass OR pwd ^<_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
	reg query HKLM /f pass /t REG_SZ /s
	reg query HKCU /f pass /t REG_SZ /s
	reg query HKLM /f pwd /t REG_SZ /s
	reg query HKCU /f pwd /t REG_SZ /s

	echo.
	echo.
	echo [i] Iterating through the drives
	echo.
	for /f %%x in ('wmic logicaldisk get name^| more') do (
		set tdrive=%%x
		if "!tdrive:~1,2!" == ":" (
			%%x
            echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-^> [+] FILES THAT CONTAINS THE WORD PASSWORD WITH EXTENSION: .xml .ini .txt *.cfg *.config ^<_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
	        findstr /s/n/m/i password *.xml *.ini *.txt *.cfg *.config 2>nul | findstr /v /i "\\AppData\\Local \\WinSxS ApnDatabase.xml \\UEV\\InboxTemplates \\Microsoft.Windows.Cloud \\Notepad\+\+\\ vmware cortana alphabet \\7-zip\\" 2>nul
            echo.
            echo.
            echo _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-^> [+] FILES WHOSE NAME CONTAINS THE WORD PASS CRED or .config not inside \Windows\ ^<_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
            dir /s/b *pass* == *cred* == *.config* == *.cfg 2>nul | findstr /v /i "\\windows\\"  
            echo.
            echo.
		)
	)
	echo.
)