#!/bin/sh
# Copyright (c) 2009-2016 Wildcroft Security Ltd.
# Policy: Level 5 (Core-Common/v149)

# If -x is enabled extraneous output appears in the collected data stream and
# SureCheck will be unable to process the results.
set +x

COLLECT=0
HOSTNAME=`hostname`
DATE=`date "+%Y-%m-%d"`
OUTPUT="SureCheck-$HOSTNAME-$DATE"
PATH=$PATH:/sbin:/usr/sbin

usage() {
	echo
	echo "To display the list of commands that the collection script will execute:"
	echo
	echo "    $0 list"
	echo
	echo "To perform collection:"
	echo
	echo "    $0 collect"
	if [ `id | cut -d= -f2 | cut -d\( -f1` != 0 ]; then
		echo
		echo "The SureCheck collection script must be run as root"
	fi
	echo
	exit;
}

case "$1" in
	[Ll][Ii][Ss][Tt])
		COLLECT=0;;
	[Cc][Oo][Ll][Ll][Ee][Cc][Tt])
		COLLECT=1;;
	*)
		usage;;
esac

if [ "$COLLECT" = 1 -a `id | cut -d= -f2 | cut -d\( -f1` != 0 ]; then
	echo "The SureCheck collection script must be run as root"
	exit
fi

collect() {
	name=$1
	cmd=$2
	if [ "$COLLECT" = 1 ]; then
		echo "----- SURECHECK-VALUE: $name -----" >> $OUTPUT
		(eval $cmd) >> $OUTPUT 2>&1
		echo "----- SURECHECK-END -----" >> $OUTPUT
	else
		echo "$cmd"
	fi
}

if [ "$COLLECT" = 1 ]; then
	echo "Collecting information..."
	cat /dev/null > $OUTPUT
	echo "----- BEGIN SURECHECK -----" >> $OUTPUT
	echo "----- SURECHECK-PLATFORM: UNIX/Linux/Ubuntu -----" >> $OUTPUT
	echo "----- SURECHECK-POLICY: 0EEDB34A-8C2D-4E75-87C7-D120ADF94A9D:Level5:Level 5 -----" >> $OUTPUT
	echo "----- SURECHECK-TERMINATOR: '----- SURECHECK-END -----' -----" >> $OUTPUT
	echo "----- SURECHECK-OPTION: SSHDConfig=/etc/ssh/sshd_config -----" >> $OUTPUT
	echo "----- SURECHECK-VALUE: SureCheck-Version -----" >> $OUTPUT
	echo "2.0.0.1368" >> $OUTPUT; echo "----- SURECHECK-END -----" >> $OUTPUT
fi

collect 'PLATFORM-LSB-RELEASE-D-S' 'lsb_release -d -s'
collect 'PLATFORM-ID-A' 'id -a'
collect 'PLATFORM-UNAME-A' 'uname -a'
collect 'PLATFORM-HOSTNAME' 'hostname'
collect '/etc/group' 'cat /etc/group'
collect '/etc/hosts.allow' 'cat /etc/hosts.allow'
collect '/etc/hosts.deny' 'cat /etc/hosts.deny'
collect '/etc/issue' 'cat /etc/issue'
collect '/etc/motd' 'cat /etc/motd'
collect '/etc/pam.conf' 'cat /etc/pam.conf'
collect '/etc/pam.d' 'for file in /etc/pam.d/*; do echo "_____ $file _____"; cat $file; done'
collect '/etc/passwd' 'cat /etc/passwd'
collect '/etc/profile' 'cat /etc/profile'
collect '/etc/rsyslog.conf' 'cat /etc/rsyslog.conf'
collect '/etc/syslog.conf' 'cat /etc/syslog.conf'
collect 'At-Allow' 'cat /etc/at.allow'
collect 'At-Deny' 'cat /etc/at.deny'
collect 'Cron-Allow' 'cat /etc/cron.allow'
collect 'Cron-Deny' 'cat /etc/cron.deny'
collect 'gcc' 'gcc -v'
collect 'gdb' 'gdb -v'
collect 'home-dir-dotfiles' 'cat /etc/passwd | awk -F: '\''{ print $6 }'\'' | grep -v "^$" | sort -u | while read d; do echo "DIRECTORY $d"; for f in $d/.[A-Za-z0-9]*; do if [ ! -h "$f" -a -f "$f" ]; then ls -ln "$f"; fi; done; done'
collect 'home-dirs' 'cat /etc/passwd | awk -F: '\''{ print $1" "$3" "$6 }'\'' | while read u i d; do printf "$u : $i : $d : "; ls -ldnL "$d"; done'
collect 'legacy-accounts' 'grep '\''^\+'\'' /etc/passwd /etc/group /etc/shadow'
collect 'ls-/etc/cron.d' 'ls -lndL /etc/cron.d'
collect 'ls-/etc/crontab' 'ls -lndL /etc/crontab'
collect 'ls-/etc/group' 'ls -lnL /etc/group'
collect 'ls-/etc/gshadow' 'ls -lndL /etc/gshadow'
collect 'ls-/etc/hosts.allow' 'ls -lndL /etc/hosts.allow'
collect 'ls-/etc/hosts.deny' 'ls -lndL /etc/hosts.deny'
collect 'ls-/etc/passwd' 'ls -lndL /etc/passwd'
collect 'ls-/etc/shadow' 'ls -lndL /etc/shadow'
collect 'ls-At-Allow' 'ls -lndL /etc/at.allow'
collect 'ls-At-Deny' 'ls -lndL /etc/at.deny'
collect 'ls-Cron-Allow' 'ls -lndL /etc/cron.allow'
collect 'ls-Cron-Deny' 'ls -lndL /etc/cron.deny'
collect 'ls-sshd_config' 'ls -lndL /etc/ssh/sshd_config'
collect 'ntp.conf' 'cat /etc/ntp.conf'
collect 'perl' 'perl -v < /dev/null'
collect 'php' 'php --version'
collect 'python' 'python -V < /dev/null'
collect 'root-PATH' 'su - root -c '\''echo _____ $PATH _____'\'''
collect 'root-PATH-perms' 'su - root -c '\''echo _____; for i in `echo $PATH | tr ":" " "`; do ls -ldnL $i; done; echo _____'\'''
collect 'rpcinfo' 'rpcinfo -p'
collect 'rsyslog-includes' 'for I in `grep '\''^$Include'\'' /etc/rsyslog.conf | cut -d'\'' '\'' -f2 | xargs`; do echo "_____ $I _____"; cat $I; done'
collect 'ruby' 'ruby -v < /dev/null'
collect 'sshd_config' 'cat /etc/ssh/sshd_config'
collect 'xinetd.conf' 'for f in /etc/xinetd.conf /etc/xinetd.d/*; do echo "_____ $f _____"; cat $f; done'
collect '/etc/audit/auditd.conf' 'cat /etc/audit/auditd.conf'
collect '/etc/bashrc' 'cat /etc/bashrc'
collect '/etc/default/useradd' 'cat /etc/default/useradd'
collect '/etc/exports' 'cat /etc/exports'
collect '/etc/fstab' 'cat /etc/fstab'
collect '/etc/fstab-links' 'for d in `grep ^/ /etc/fstab  | cut -d '\'' '\'' -f 1 | xargs`; do ls -lnd $d; done'
collect '/etc/inittab' 'cat /etc/inittab'
collect '/etc/login.defs' 'cat /etc/login.defs'
collect '/etc/securetty' 'cat /etc/securetty'
collect 'RemovableDevices' 'for d in /sys/block/*; do echo -n "$d: "; cat $d/removable; done'
collect 'auditctl-l' 'auditctl -l | cat'
collect 'auditctl-s' 'auditctl -s | cat'
collect 'available-modules' 'find "/lib/modules/$(uname -r)" -name "*.ko" -exec basename {} \;'
collect 'blkid' 'blkid'
collect 'blkid-links' 'for d in `blkid | cut -d: -f1 | xargs`; do ls -lnd $d; done'
collect 'gdm-config' 'cat /etc/gdm/custom.conf'
collect 'gdm-config-simple-greeter' 'gconftool-2 -R /apps/gdm/simple-greeter'
collect 'getenforce' 'getenforce'
collect 'grub.conf' 'cat /boot/grub/grub.cfg'
collect 'ifconfig-a' 'ifconfig -a'
collect 'iwconfig' 'iwconfig'
collect 'kernel-config' 'cat /boot/config-`uname -r`'
collect 'legacy-accounts' 'grep '\''^\+'\'' /etc/passwd /etc/group /etc/shadow /etc/gshadow'
collect 'ls-/etc/cron.daily' 'ls -lndL /etc/cron.daily'
collect 'ls-/etc/cron.hourly' 'ls -lndL /etc/cron.hourly'
collect 'ls-/etc/cron.monthly' 'ls -lndL /etc/cron.monthly'
collect 'ls-/etc/cron.weekly' 'ls -lndL /etc/cron.weekly'
collect 'ls-/var/log' 'find /var/log -exec ls -ldnL {} \;'
collect 'ls-grub.conf' 'ls -lnLd /boot/grub/grub.cfg'
collect 'lsmod' 'lsmod'
collect 'modprobe.conf' 'for d in /etc/modprobe.d/*; do echo ___ $d ___; cat $d; done; echo ___ /etc/modprobe.conf ___; cat /etc/modprobe.conf'
collect 'netstat-an' 'netstat -tuln'
collect 'ps' 'ps -e -o pid= -o ppid= -o uid= -o gid= -o comm= -o args='
collect 'runlevel' '/sbin/runlevel'
if [ "$COLLECT" = 1 ]; then printf "Searching for SetUID/SetGID files..."; fi
collect 'suid-sgid-files' 'for P in `mount | egrep "type (ext[234]|reiserfs)" | cut -d'\'' '\'' -f3`; do find $P -xdev -type f -perm /0111 \( -perm -04000 -o -perm -02000 \) -exec ls -ldnL {} \; ; done'
if [ "$COLLECT" = 1 ]; then echo; fi
collect 'sysctl-a' 'sysctl -a'
collect 'uname-a' 'uname -a'
if [ "$COLLECT" = 1 ]; then printf "Searching for unowned files..."; fi
collect 'unowned-files' 'for P in `mount | egrep "type (ext[234]|reiserfs)" | cut -d'\'' '\'' -f3`; do find $P -xdev -nouser -o -nogroup -print; done'
if [ "$COLLECT" = 1 ]; then echo; fi
if [ "$COLLECT" = 1 ]; then printf "Searching for world writeable directories..."; fi
collect 'world-write-dir' 'for P in `mount | egrep "type (ext[234]|reiserfs)" | cut -d'\'' '\'' -f3`; do find $P -xdev -type d \( -perm -0002 -a ! -perm -1000 \) -print; done'
if [ "$COLLECT" = 1 ]; then echo; fi
if [ "$COLLECT" = 1 ]; then printf "Searching for world writeable files..."; fi
collect 'world-write-file' 'for P in `mount | egrep "type (ext[234]|reiserfs)" | cut -d'\'' '\'' -f3`; do find $P -xdev -type f  \( -perm -0002 -a ! -perm -1000 \) -print; done'
if [ "$COLLECT" = 1 ]; then echo; fi
collect '/etc/apt/sources.list' 'cat /etc/apt/sources.list'
collect 'dpkg-architecture' 'dpkg --print-architecture'
collect 'dpkg-l' 'dpkg -l | cat'
collect 'initctl-list' 'initctl list'
collect 'ntpd-options' 'cat /etc/init.d/ntp'
collect 'password-properties' 'passwd -S --all'
collect 'service-status-all' 'service --status-all'
collect 'ufw-status' 'ufw status'

if [ "$COLLECT" = 1 ]; then
	echo "----- END SURECHECK -----" >> $OUTPUT
	gzip $OUTPUT
	echo "Results in $OUTPUT.gz"
fi
