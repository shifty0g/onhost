#!/bin/sh

#17-08-18
# Needs tidying up 

# Text colors
NORMAL="\033[0;39m"
YELLOW="\033[1;33m"
GREEN="\033[1;32m"
BLUE="\033[0;34m"
BAD="\033[1;31m"

# Temporarily export required directories to the PATH
export PATH=$PATH:/sbin:/bin:/usr/bin

# Check if current user is root
if [ `id | cut -d= -f2 | cut -d\( -f1` != 0 ] ; then
    printf "\n ${BAD}[!]${NORMAL} Please run the script as root\n\n"
    exit
fi

# Handle user pressing CTRL+C to exit script early
trap ctrl_c INT
ctrl_c() {
    printf "\n\n ${BAD}[!]${NORMAL} Script stopped by user at ${GREEN}`date +"%H:%M:%S"`${NORMAL}\n\n"
    exit
}

# Banner
printf "\n${BLUE}                   00          ${GREEN}                         dP 00   dP    \n"
printf "${BLUE}                               ${GREEN}                         88      88    \n"
printf "${BLUE} dP    dP 88d888b. dP dP.  .dP ${GREEN} .d8888b. dP    dP .d888b88 dP d8888P  \n"
printf "${BLUE} 88    88 88'  \`88 88  \`8bd8'  ${GREEN} 88'  \`88 88    88 88'  \`88 88   88    \n"
printf "${BLUE} 88.  .88 88    88 88  .d88b.  ${GREEN} 88.  .88 88.  .88 88.  .88 88   88    \n"
printf "${BLUE} \`88888P' dP    dP dP dP'  \`dP ${GREEN} \`88888P8 \`88888P' \`88888P8 dP   dP    \n\n"
printf "                        ${YELLOW}UNIX Collection Script${NORMAL}        \n\n"

# Confirm whether the script should continue to run
printf " ${BLUE}[i]${NORMAL} Run the collection script? [Y/N] "
read CONTINUE
printf "\n"
if [ -z `echo ${CONTINUE} | egrep -i '(^Y$)|(YES)'` ] ; then
    exit
fi

###############
## variables ##
###############

HOSTNAME=$(hostname -s | `which tr` '[:lower:]' '[:upper:]')
DATE=$(date "+%Y-%m-%d")

# Output directory. Change as required, exclude final '/' character
TMP="/tmp"

# Check if output directory exists
if [ ! -d ${TMP} ] ; then
    printf "\n ${BAD}[!]${NORMAL} ${TMP} doesn't exist\n\n"
    exit
fi

# Results folder name
OUT=${TMP}/UNIX_AUDIT-${HOSTNAME}"_"${DATE}

######################
## start collection ##
######################

printf " Collection started at ${GREEN}`date +"%H:%M:%S"`${NORMAL}\n\n"
echo 'Hostname              : ' $(hostname) | grep --color 'Hostname'
echo 'Current Shell in Use  : ' $SHELL | grep --color 'Current Shell in Use'
echo 'Current User          : ' $(whoami) | grep --color 'Current User'
echo 'User ID               : ' $(id) | grep --color 'User ID'
echo 'User Home Directory   : ' $HOME | grep --color 'User Home Directory'
echo 'PWD                   : ' $(pwd) | grep --color 'PWD'
echo 'Kernel                : ' $(uname -a) | grep --color 'Kernel' 
echo 'Operating System:     : ' $(cat /etc/*release | grep --color 'PRETTY_NAME' | cut -d'"' -f2) # OS


# Check whether the output directory exists
if [ ! -d ${OUT} ] ; then
    mkdir -p ${OUT}
fi

# Get OS
if [ -f "/etc/issue" ] ; then
    OS=$(cat /etc/issue)
fi

######################
## red hat commands ##
######################

if [ -f "/etc/redhat-release" ] ; then
    cat /etc/redhat-release > ${OUT}/redhat-release.txt 2>&1
    cat /etc/yum.conf > ${OUT}/yum.txt 2>&1
    cat /boot/grub/grub.conf > ${OUT}/grub.txt 2>&1
    cat /etc/sysconfig/ntpd > ${OUT}/ntpd-options.txt 2>&1
    yum repolist > ${OUT}/yum-repolist.txt 2>&1
    rpm -qia |grep -E "^(Name|Version|Release|Signature)" > ${OUT}/rpm.txt 2>&1
    rpm -Va --nomtime --nosize --nomd5 --nolinkto --noscripts > ${OUT}/rpm-verify.txt 2>&1
    # Password Properties
    for u in `cut -d: -f1 /etc/passwd | xargs`; do passwd -S $u; done > ${OUT}/password-properties.txt 2>&1
    # RPM GPG Key
    gpg --quiet --no-options --with-fingerprint /etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release > ${OUT}/rpm-gpg-key.txt 2>&1
	#nopc
	/bin/rpm -qa --qf '%{NAME}-%{VERSION}-%{RELEASE}|%{EPOCH}\n' > ${OUT}/patchlist.txt 2>&1

##############################
## ubuntu specific commands ##
##############################

elif [ -f "/etc/lsb-release" ] ; then
    cat /etc/lsb-release > ${OUT}/lsb-release.txt 2>&1
    cat /boot/grub/grub.cfg > ${OUT}/grub.txt 2>&1
    passwd -S --all > ${OUT}/password-properties.txt 2>&1
    cat /etc/init.d/ntp > ${OUT}/ntpd-options.txt 2>&1
    ufw status > ${OUT}/ufw-status.txt 2>&1
    dpkg -l > ${OUT}/dpkg.txt 2>&1
	#nopc
	dpkg -l|cat > ${OUT}/patchlist.txt 2>&1

###################
## suse commands ##
###################

elif [ -f "/etc/SuSE-release" ] ; then
    cat /etc/SuSE-release > ${OUT}/suse-release.txt 2>&1
    cat /boot/grub/grub.lst > ${OUT}/grub.txt 2>&1
    passwd -Sa > ${OUT}/password-properties.txt 2>&1
    chkconfig -A -l |cat > ${OUT}/chkconfig.txt 2>&1
	#nopc
	/bin/rpm -qa --qf '%{NAME}-%{VERSION}-%{RELEASE}|%{EPOCH}\n' > ${OUT}/patchlist.txt 2>&1

#####################
## debian commands ##
#####################

elif [ -f "/etc/debian_version" ]; then
    cat /etc/debian_version > ${OUT}/debian-version.txt 2>&1
	#nopc
	dpkg -l|cat > ${OUT}/patchlist.txt 2>&1

######################
## solaris commands ##
######################

elif [ -n `echo $OS |egrep -io 'SOLARIS'` ] ; then
    printf "\n Operating System   : Solaris\n"
    cat /etc/.login > ${OUT}/etc-dot-login.txt 2>&1
    cat /etc/coreadm.conf > ${OUT}/etc-coreadm.txt 2>&1
    cat /etc/default/cron > ${OUT}/etc-default-cron.txt 2>&1
    cat /etc/default/init > ${OUT}/etc-default-init.txt 2>&1
    cat /etc/default/keyserv > ${OUT}/etc-default-keyserv.txt 2>&1
    cat /etc/default/login > ${OUT}/etc-default-login.txt 2>&1
    cat /etc/default/passwd > ${OUT}/etc-default-passwd.txt 2>&1
    cat /etc/default/telnetd > ${OUT}/etc-default-telnetd.txt 2>&1
    cat /etc/dfs/sharetab > ${OUT}/etc-dfs-sharetab.txt 2>&1

    echo -e "---------- BANNER ----------\n" > ${OUT}/ftpd.txt
    cat /etc/ftpd/banner.msg >> ${OUT}/ftpd.txt 2>&1
    echo -e "\n---------- ACCESS ----------\n" >> ${OUT}/ftpd.txt
    cat /etc/ftpd/ftpaccess >> ${OUT}/ftpd.txt 2>&1
    echo -e "\n---------- USERS ----------\n" >> ${OUT}/ftpd.txt
    cat /etc/ftpd/ftpusers >> ${OUT}/ftpd.txt 2>&1

    cat /etc/profile > ${OUT}/etc-profile.txt 2>&1
    cat /etc/release > ${OUT}/etc-release.txt 2>&1
    cat /etc/rmount > ${OUT}/etc-rmount.txt 2>&1
    cat /etc/security/policy.conf > ${OUT}/etc-security-policy.txt 2>&1
    cat /etc/system > ${OUT}/etc-system.txt 2>&1
    cat /usr/sadm/defadduser > ${OUT}/etc-sadm-defadduser.txt 2>&1
    cat /usr/openwin/lib/app-defaults/XScreenSaver > ${OUT}/xscreensaver.txt 2>&1

    for file in /usr/dt/config/*/Xresources; do echo "_____ $file _____"; cat "$file"; done > ${OUT}/xresources.txt 2>&1

    ndd /dev/arp arp_cleanup_interval > ${OUT}/arp-cleanup-interval.txt 2>&1
    /usr/sbin/consadm -p > ${OUT}/consadm.txt 2>&1
    coreadm -p > ${OUT}/coreadm.txt 2>&1
    eeprom -p > ${OUT}/eeprom.txt 2>&1

    for F in /etc/dt/config/*/sys.resources; do echo "___ $F ___"; egrep "dtsession\*(saver|lock)Timeout" $F; done > ${OUT}/etc-sys-resources.txt 2>&1
    find / \( -fstype nfs -o -fstype cachefs -o -fstype ctfs -o -fstype mntfs -o -fstype objfs -o -fstype proc \) -prune -o -xattr -ls > ${OUT}/extended-attributes.txt 2>&1
    cat /etc/X11/gdm/gdm.conf > ${OUT}/etc-x11-gdm.txt 2>&1
    inetadm -p > ${OUT}/inetadm.txt 2>&1
    inetadm -l svc:/network/ftp > ${OUT}/inetadm-ftp.txt 2>&1
    isainfo -b > ${OUT}/isainfo.txt 2>&1
    mount -p > ${OUT}/mount.txt 2>&1
    logins -xao > ${OUT}/password-properties.txt 2>&1
    pkginfo -x > ${OUT}/pkginfo.txt 2>&1
    pmadm -l > ${OUT}/pmadm.txt 2>&1
    ps -e -o pid,ppid,uid,gid,fname,args > ${OUT}/processes.txt 2>&1
    routeadm -p > ${OUT}/routeadm.txt 2>&1
    cat /etc/mail/sendmail.cf > ${OUT}/sendmail.txt 2>&1
    showrev -a > ${OUT}/showrev.txt 2>&1
    for file in /usr/dt/config/*/sys.resources; do echo "_____ $file _____"; cat "$file"; done > ${OUT}/sys-resources.txt 2>&1
    for F in /usr/dt/config/*/sys.resources; do echo "___ $F ___"; egrep "dtsession\*(saver|lock)Timeout" $F; done > ${OUT}/usr-sys-resources.txt 2>&1
    gconftool-2 -R /apps/gdm/simple-greeter > ${OUT}/simple-greeter.txt 2>&1
    bootadm list-menu > ${OUT}/grub.txt 2>&1
    cat /etc/security/audit_control > ${OUT}/audit_control.txt 2>&1
    cat /etc/security/audit_event > ${OUT}/audit_event.txt 2>&1
    cat /etc/security/audit_startup > ${OUT}/audit_startup.txt 2>&1
    cat /etc/security/audit_user > ${OUT}/audit_user.txt 2>&1

    echo -e "---------- auditconfig-getcond ----------\n" > ${OUT}/auditconfig.txt
    auditconfig -getcond >> ${OUT}/auditconfig.txt 2>&1
    echo -e "---------- auditconfig-getflags ----------\n" >> ${OUT}/auditconfig.txt
    auditconfig -getflags >> ${OUT}/auditconfig.txt 2>&1
    echo -e "---------- auditconfig-getnaflags ----------\n" >> ${OUT}/auditconfig.txt
    auditconfig -getnaflags >> ${OUT}/auditconfig.txt 2>&1
    echo -e "---------- auditconfig-getplugin ----------\n" >> ${OUT}/auditconfig.txt
    auditconfig -getplugin >> ${OUT}/auditconfig.txt 2>&1
    echo -e "---------- auditconfig-getpolicy ----------\n" >> ${OUT}/auditconfig.txt
    auditconfig -getpolicy >> ${OUT}/auditconfig.txt 2>&1
	
	#nopc
	/usr/bin/pkginfo -x | awk '{ if ( NR % 2 ) { prev = $1 } else  { print prev" "$0  } }' > ${OUT}/pkginfo.txt 2>&1
fi

##########################
## system configuration ##
##########################

printf "\n ${YELLOW}[-]${NORMAL} Configuration\n"

# Systemctl
if [ ! -z `which systemctl 2>/dev/null` ] ; then
    printf "     Systemd installed\n"
    systemctl list-unit-files --type=service > ${OUT}/systemd-services.txt 2>&1
fi

# ClamAV
if [ ! -z `which clamscan 2>/dev/null` ] ; then
    printf "     ClavAV installed\n"
    clamscan -V > ${OUT}/clamav-version.txt 2>&1
    head -n 1 /var/lib/clamav/daily.cld > ${OUT}/clamav-daily-defs.txt 2>&1
    head -n 1 /var/lib/clamav/main.cvd > ${OUT}/clamav-main-defs.txt 2>&1
    cat /var/log/clamav/freshclam.log > ${OUT}/clamav-freshclam-log.txt 2>&1
else
    printf "     ClavAV not installed\n"
fi

# AppArmor
if [ ! -z `which apparmor_status 2>/dev/null` ] ; then
    printf "     AppArmor installed\n"
    apparmor_status > ${OUT}/apparmor-status.txt 2>&1
else
    printf "     AppArmor not installed\n"
fi

# Ip6tables
if [ ! -z `which ip6tables 2>/dev/null` ] ; then
    printf "     IP6Tables detected\n"
    ip6tables -L -v > ${OUT}/ip6tables.txt 2>&1
fi

# Collect processes if not solaris
if [ -z `echo $OS |egrep -io 'SOLARIS'` ] ; then
    ps aux > ${OUT}/processes.txt 2>&1
fi

printf "\n ${YELLOW}[-]${NORMAL} Common files"
cat /boot/config-`uname -r` > ${OUT}/boot-kernel-config.txt 2>&1
cat /etc/anacrontab > ${OUT}/etc-anacrontab.txt 2>&1
cat /etc/bashrc > ${OUT}/etc-bashrc.txt 2>&1
cat /etc/audit/auditd.conf > ${OUT}/etc-audit-auditd-conf.txt 2>&1
cat /etc/audit/audit.rules > ${OUT}/etc-audit-auditd-rules.txt 2>&1
cat /etc/crontab > ${OUT}/etc-crontab.txt 2>&1
cat /etc/at.allow > ${OUT}/etc-at-allow.txt 2>&1
cat /etc/at.deny > ${OUT}/etc-at-deny.txt 2>&1
cat /etc/cron.allow > ${OUT}/etc-cron-allow.txt 2>&1
cat /etc/cron.deny > ${OUT}/etc-cron-deny.txt 2>&1
cat /etc/cron.d/at.allow > ${OUT}/etc-crond-at-allow.txt 2>&1
cat /etc/cron.d/at.deny > ${OUT}/etc-crond-at-deny.txt 2>&1
cat /etc/cron.d/cron.allow > ${OUT}/etc-crond-allow.txt 2>&1
cat /etc/cron.d/cron.deny > ${OUT}/etc-crond-deny.txt 2>&1
cat /etc/default/useradd > ${OUT}/etc-default-useradd.txt 2>&1
cat /etc/fstab > ${OUT}/etc-fstab.txt 2>&1
cat /etc/exports > ${OUT}/etc-exports.txt 2>&1
cat /etc/group > ${OUT}/etc-group.txt 2>&1
cat /etc/hosts.allow > ${OUT}/etc-hosts-allow.txt 2>&1
cat /etc/hosts.deny > ${OUT}/etc-hosts-deny.txt 2>&1
cat /etc/inittab > ${OUT}/etc-initab.txt 2>&1
cat /etc/issue > ${OUT}/etc-issue.txt 2>&1
cat /etc/issue.net > ${OUT}/etc-issue-net.txt 2>&1
cat /etc/login.defs > ${OUT}/etc-login-defs.txt 2>&1
cat /etc/motd > ${OUT}/etc-motd.txt 2>&1
cat /etc/ntp.conf > ${OUT}/etc-ntp-conf.txt 2>&1
cat /etc/os-release > ${OUT}/etc-osrelease.txt 2>&1
cat /etc/passwd > ${OUT}/etc-passwd.txt 2>&1
cat /etc/pam.conf > ${OUT}/etc-pam.txt 2>&1
cat /etc/profile > ${OUT}/etc-profile.txt 2>&1
cat /etc/rsyslog.conf > ${OUT}/etc-rsyslog-conf.txt 2>&1
cat /etc/securetty > ${OUT}/etc-securetty.txt 2>&1
cat /etc/shadow > ${OUT}/etc-shadow.txt 2>&1
cat /etc/ssh/sshd_config > ${OUT}/etc-sshd-conf.txt 2>&1
cat /etc/sudoers > ${OUT}/etc-sudoers.txt 2>&1
cat /etc/sysconfig/init > ${OUT}/etc-sysconfig-init.txt 2>&1
cat /etc/syslog.conf > ${OUT}/etc-syslog.txt 2>&1
cat /etc/syslog-ng/syslog-ng.conf > ${OUT}/etc-syslog-ng-conf.txt 2>&1
cat /etc/apt/sources.list > ${OUT}/etc-apt-sources.txt 2>&1
cat /etc/security/limits.conf > ${OUT}/etc-security-limits.txt 2>&1
cat /etc/security/pwquality.conf > ${OUT}/etc-security-pwquality.txt 2>&1
cat /etc/sysctl.conf > ${OUT}/etc-sysctl-conf.txt 2>&1
cat /etc/selinux/config > ${OUT}/etc-selinux-config.txt 2>&1
cat /etc/chrony.conf > ${OUT}/etc-chrony.txt 2>&1
cat /etc/modprobe.d/CIS.conf > ${OUT}/etc-modeprobe.d-CIS-conf.txt 2>&1
cat /etc/logrotate.conf > ${OUT}/etc-logrotate-conf.txt 2>&1


cat /proc/version > ${OUT}/proc-version.txt 2>&1


rpm -qa > ${OUT}/rpm-qa.txt 2>&1
yum check-update > ${OUT}/yum-update.txt 2>&1
/bin/rpm -qa --qf '%{NAME}-%{VERSION}-%{RELEASE}|%{EPOCH}\n' > ${OUT}/patchlist3.txt 2>&1

iptables -L -v > ${OUT}/iptables.txt 2>&1
initctl list > ${OUT}/initctl.txt 2>&1
service --status-all > ${OUT}/init-services.txt 2>&1
lsmod > ${OUT}/lsmod.txt 2>&1
authconfig --test > ${OUT}/auth-config.txt 2>&1
auditctl -l > ${OUT}/auditctl.txt 2>&1
auditctl -s >> ${OUT}/auditctl.txt 2>&1
chkconfig --list > ${OUT}/chkconfig.txt 2>&1
getenforce > ${OUT}/getenforce.txt 2>&1
ifconfig -a > ${OUT}/network-interfaces.txt 2>&1
iwconfig >> ${OUT}/network-interfaces.txt 2>&1
netstat -panelut > ${OUT}/netstat.txt 2>&1
netstat -ln > ${OUT}/netstat-listening.txt 2>&1 
service --status-all > ${OUT}/services.txt 2>&1
sysctl -a > ${OUT}/sysctl.txt 2>&1
uname -a > ${OUT}/uname.txt 2>&1
cat /etc/*release > ${OUT}/release2.txt 2>&1
sestatus -v >> ${OUT}/etc-selinux-config.txt 2>&1

# Can take a long time to complete and may create a large file
#printf "${YELLOW}[-]${NORMAL} Complete File List"
#ls -lAhR / > tree.txt

# Modprobe
printf "\n ${YELLOW}[-]${NORMAL} Modprobe"
for d in /etc/modprobe.d/*; do echo ___ $d ___ >> ${OUT}/modprobe-conf.txt 2>&1 ; cat $d >> ${OUT}/modprobe-conf.txt 2>&1; done

if [ -f "/etc/modprobe.conf" ] ; then
    echo ___ /etc/modprobe.conf ___ >> ${OUT}/modprobe-conf.txt 2>&1 ; cat /etc/modprobe.conf >> ${OUT}/modprobe-conf.txt 2>&1
fi

# Block devices
printf "\n ${YELLOW}[-]${NORMAL} Block Devices"
echo -e "---------- BLKID ----------\n" > ${OUT}/blkid.txt
blkid >> ${OUT}/blkid.txt 2>&1
echo -e "\n---------- BLKID-LINKS ----------\n" >> ${OUT}/blkid.txt
for d in `blkid | cut -d: -f1 | xargs`; do ls -lnd $d; done >> ${OUT}/blkid.txt 2>&1

# Available modules
printf "\n ${YELLOW}[-]${NORMAL} Available Modules"
find "/lib/modules/$(uname -r)" -name "*.ko" -exec basename {} \; > ${OUT}/available-modules.txt 2>&1

# FSTAB links
printf "\n ${YELLOW}[-]${NORMAL} Fstab"
for d in `grep ^/ /etc/fstab |cut -d ''' ''' -f 1 | xargs` ; do ls -lnd $d ; done > ${OUT}/fstab-links.txt 2>&1

# Removable devices
printf "\n ${YELLOW}[-]${NORMAL} Removable Devices"
for d in /sys/block/*; do echo -n "$d: "; cat $d/removable; done > ${OUT}/removable-devices.txt 2>&1

# Pam.d
printf "\n ${YELLOW}[-]${NORMAL} Pam.d"
for f in /etc/pam.d/*; do echo "--- $f ---"; cat $f; done > ${OUT}/pamd.txt 2>&1

# Xinet.d
printf "\n ${YELLOW}[-]${NORMAL} Xinet.d"
for f in /etc/xinetd.conf /etc/xinetd.d/*; do echo "--- $f ---"; cat $f; done > ${OUT}/xinetd.txt 2>&1
cat /etc/inetd.conf > ${OUT}/inetd.txt 2>&1


# SUID & SGID files
printf "\n ${YELLOW}[-]${NORMAL} SUID & SGID Files"
find / -path /proc -prune -o -type f \( -perm -4000 -o -perm -2000 \) | grep --color -i -E 'root||/usr/bin||/bin||/usr/sbin||/sbin' -ls > ${OUT}/suid-sgid-files.txt 2>&1

# Unowned files
printf "\n ${YELLOW}[-]${NORMAL} Unowned Files"
find / -path /proc -prune -o -type f -nouser -nogroup -ls > ${OUT}/unowned-files.txt 2>&1

# World-writable files
printf "\n ${YELLOW}[-]${NORMAL} World-Writable Files"
find / -path /proc -prune -o -type f -perm -0002 -ls | grep --color -i -E 'root||/usr/bin||/bin||/usr/sbin||/sbin' >  ${OUT}/world-writable-files.txt 2>&1

# World-writable directories
printf "\n ${YELLOW}[-]${NORMAL} World-Writable Directories"
find / -path /proc -prune -o -type d -perm -o+w -ls > ${OUT}/world-writable-directories.txt 2>&1

# Local software
printf "\n ${YELLOW}[-]${NORMAL} Local Software"
ls -l /opt/ /usr/local/ /opt/local/ /opt/bin/ /usr/local/bin/ /opt/local/bin/ > ${OUT}/local-software.txt 2>&1

# Home directory '.' files
printf "\n ${YELLOW}[-]${NORMAL} Home Directory '.' Files"
cat /etc/passwd |cut -d: -f6 | grep -v "^\/$" | sort -u | while read d; do echo "DIRECTORY $d"; for f in $d/.[A-Za-z0-9]*; do if [ ! -h "$f" -a -f "$f" ]; then ls -lhn "$f"; fi; done; done > ${OUT}/home-directory-dot-files.txt 2>&1

# Home directory permissions
printf "\n ${YELLOW}[-]${NORMAL} Home Directory Permissions"
cat /etc/passwd |cut -d: -f6 | grep -v "^\/$" | while read u; do  ls -ldhnL "$u"; done > ${OUT}/home-directory-permissions.txt 2>&1

# Development tools
printf "\n ${YELLOW}[-]${NORMAL} Development Tools"
echo -e "---------- GCC ----------\n" > ${OUT}/development-tools.txt
gcc -v >> ${OUT}/development-tools.txt 2>&1
echo -e "\n---------- GDB ----------\n" >> ${OUT}/development-tools.txt
gdb -v >> ${OUT}/development-tools.txt 2>&1
echo -e "\n---------- PERL ----------\n" >> ${OUT}/development-tools.txt
perl -v >> ${OUT}/development-tools.txt 2>&1
echo -e "\n---------- PYTHON ----------\n" >> ${OUT}/development-tools.txt
python -V >> ${OUT}/development-tools.txt 2>&1
echo -e "\n---------- PHP ----------\n" >> ${OUT}/development-tools.txt
php --version >> ${OUT}/development-tools.txt 2>&1

chmod -R 755 ${OUT}
printf "\n\n Collection complete at ${GREEN}`date +"%H:%M:%S"`${NORMAL}\n\n"
printf " Results: ${OUT}\n\n"
printf " mv ${OUT} ."
echo ""