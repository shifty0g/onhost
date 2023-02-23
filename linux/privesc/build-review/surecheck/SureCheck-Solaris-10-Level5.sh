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
	echo "----- SURECHECK-PLATFORM: UNIX/Solaris/10 -----" >> $OUTPUT
	echo "----- SURECHECK-POLICY: 0EEDB34A-8C2D-4E75-87C7-D120ADF94A9D:Level5:Level 5 -----" >> $OUTPUT
	echo "----- SURECHECK-TERMINATOR: '----- SURECHECK-END -----' -----" >> $OUTPUT
	echo "----- SURECHECK-OPTION: SSHDConfig=/etc/ssh/sshd_config -----" >> $OUTPUT
	echo "----- SURECHECK-VALUE: SureCheck-Version -----" >> $OUTPUT
	echo "2.0.0.1368" >> $OUTPUT; echo "----- SURECHECK-END -----" >> $OUTPUT
fi

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
collect 'At-Allow' 'cat /etc/cron.d/at.allow'
collect 'At-Deny' 'cat /etc/cron.d/at.deny'
collect 'Cron-Allow' 'cat /etc/cron.d/cron.allow'
collect 'Cron-Deny' 'cat /etc/cron.d/cron.deny'
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
collect 'ls-At-Allow' 'ls -lndL /etc/cron.d/at.allow'
collect 'ls-At-Deny' 'ls -lndL /etc/cron.d/at.deny'
collect 'ls-Cron-Allow' 'ls -lndL /etc/cron.d/cron.allow'
collect 'ls-Cron-Deny' 'ls -lndL /etc/cron.d/cron.deny'
collect 'ls-sshd_config' 'ls -lndL /etc/ssh/sshd_config'
collect 'ntp.conf' 'cat /etc/inet/ntp.conf'
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
collect '/etc/.login' 'cat /etc/.login'
collect '/etc/coreadm.conf' 'cat /etc/coreadm.conf'
collect '/etc/default/cron' 'cat /etc/default/cron'
collect '/etc/default/init' 'cat /etc/default/init'
collect '/etc/default/keyserv' 'cat /etc/default/keyserv'
collect '/etc/default/login' 'cat /etc/default/login'
collect '/etc/default/passwd' 'cat /etc/default/passwd'
collect '/etc/default/telnetd' 'cat /etc/default/telnetd'
collect '/etc/dfs/sharetab' 'cat /etc/dfs/sharetab'
collect '/etc/ftpd/banner.msg' 'cat /etc/ftpd/banner.msg'
collect '/etc/ftpd/ftpaccess' 'cat /etc/ftpd/ftpaccess'
collect '/etc/ftpd/ftpusers' 'cat /etc/ftpd/ftpusers'
collect '/etc/profile' 'cat /etc/profile'
collect '/etc/release' 'cat /etc/release'
collect '/etc/rmmount.conf' 'cat /etc/rmmount.conf'
collect '/etc/security/policy.conf' 'cat /etc/security/policy.conf'
collect '/etc/system' 'cat /etc/system'
collect '/usr/sadm/defadduser' 'cat /usr/sadm/defadduser'
collect 'XScreenSaver' 'cat /usr/openwin/lib/app-defaults/XScreenSaver'
collect 'Xresources' 'for file in /usr/dt/config/*/Xresources; do echo "_____ $file _____"; cat "$file"; done'
collect 'arp-cleanup-interval' 'ndd /dev/arp arp_cleanup_interval'
collect 'consadm-p' '/usr/sbin/consadm -p'
collect 'coreadm' 'coreadm'
collect 'eeprom' 'eeprom'
collect 'etc-sys-resources' 'for F in /etc/dt/config/*/sys.resources; do echo "___ $F ___"; egrep "dtsession\*(saver|lock)Timeout" $F; done'
if [ "$COLLECT" = 1 ]; then printf "Searching for extended attributes..."; fi
collect 'extended-attribites' 'find / \( -fstype nfs -o -fstype cachefs -o -fstype ctfs -o -fstype mntfs -o -fstype objfs -o -fstype proc \) -prune -o -xattr -ls'
if [ "$COLLECT" = 1 ]; then echo; fi
collect 'gdm-config' 'cat /etc/X11/gdm/gdm.conf'
collect 'ifconfig-a' 'ifconfig -a'
collect 'inetadm' 'inetadm -p'
collect 'inetadmin-ftp' 'inetadm -l svc:/network/ftp'
collect 'ip-forward-directed-broadcasts' 'ndd /dev/ip ip_forward_directed_broadcasts'
collect 'ip-ire-arp-interval' 'ndd /dev/ip ip_ire_arp_interval'
collect 'ip-strict-dst-multihoming' 'ndd /dev/ip ip_strict_dst_multihoming'
collect 'ip6-strict-dst-multihoming' 'ndd /dev/ip ip6_strict_dst_multihoming'
collect 'ip6_forward_src_routed' 'ndd /dev/ip ip6_forward_src_routed'
collect 'ip6_forwarding' 'ndd /dev/ip ip6_forwarding'
collect 'ip6_ignore_redirect' 'ndd /dev/ip ip6_ignore_redirect'
collect 'ip6_respond_to_echo_multicast' 'ndd /dev/ip ip6_respond_to_echo_multicast'
collect 'ip6_send_redirects' 'ndd /dev/ip ip6_send_redirects'
collect 'ip6_strict_dst_multihoming' 'ndd /dev/ip ip6_strict_dst_multihoming'
collect 'ip_forward_src_routed' 'ndd /dev/ip ip_forward_src_routed'
collect 'ip_forwarding' 'ndd /dev/ip ip_forwarding'
collect 'ip_ignore_redirect' 'ndd /dev/ip ip_ignore_redirect'
collect 'ip_respond_to_address_mask_broadcast' 'ndd /dev/ip ip_respond_to_address_mask_broadcast'
collect 'ip_respond_to_echo_broadcast' 'ndd /dev/ip ip_respond_to_echo_broadcast'
collect 'ip_respond_to_echo_multicast' 'ndd /dev/ip ip_respond_to_echo_multicast'
collect 'ip_respond_to_timestamp' 'ndd /dev/ip ip_respond_to_timestamp'
collect 'ip_respond_to_timestamp_broadcast' 'ndd /dev/ip ip_respond_to_timestamp_broadcast'
collect 'ip_send_redirects' 'ndd /dev/ip ip_send_redirects'
collect 'ip_strict_dst_multihoming' 'ndd /dev/ip ip_strict_dst_multihoming'
collect 'isainfo-b' 'isainfo -b'
collect 'ls-/etc/oshadow' 'ls -lnL /etc/oshadow'
collect 'ls-/var/adm/loginlog' 'ls -lnL /var/adm/loginlog'
collect 'ls-/var/cron/log' 'ls -lnL /var/cron/log'
collect 'ls-audit_class' 'ls -lndL /etc/security/audit_class'
collect 'ls-audit_control' 'ls -lndL /etc/security/audit_control'
collect 'ls-audit_event' 'ls -lndL /etc/security/audit_event'
collect 'ls-audit_startup' 'ls -lndL /etc/security/audit_startup'
collect 'ls-audit_user' 'ls -lndL /etc/security/audit_user'
collect 'ls-core-global' 'ls -ldnL `dirname \`grep COREADM_GLOB_PATTERN /etc/coreadm.conf | cut -d= -f 2\``'
collect 'ls-core-init' 'ls -ldnL `dirname \`grep COREADM_INIT_PATTERN /etc/coreadm.conf | cut -d= -f 2\``'
collect 'mount-p' 'mount -p'
collect 'netstat-an' 'netstat -an'
collect 'password-properties' 'logins -xao'
if [ "$COLLECT" = 1 ]; then printf "Checking installed packages..."; fi
collect 'pkginfo' 'pkginfo -x'
if [ "$COLLECT" = 1 ]; then echo; fi
collect 'pmadm-l' 'pmadm -l'
collect 'ps' 'ps -e -o pid,ppid,uid,gid,fname,args'
collect 'root-PATH' 'echo _____ $PATH _____'
collect 'root-PATH-perms' 'echo _____; for i in `echo $PATH | tr ":" " "`; do ls -ldnL $i; done; echo _____'
collect 'routeadm-p' 'routeadm -p'
collect 'sendmail.cf' 'cat /etc/mail/sendmail.cf'
collect 'showrev-a' 'showrev -a'
if [ "$COLLECT" = 1 ]; then printf "Searching for SetUID/SetGID files..."; fi
collect 'suid-sgid-files' 'find / \( -fstype nfs -o -fstype cachefs -o -fstype ctfs -o -fstype mntfs -o -fstype objfs -o -fstype proc \) -prune -o -type f \( -perm -04000 -o -perm -02000 \) -ls  -exec elfsign verify -e {} \;'
if [ "$COLLECT" = 1 ]; then echo; fi
collect 'svcs' 'svcs -a'
collect 'sys.resources' 'for file in /usr/dt/config/*/sys.resources; do echo "_____ $file _____"; cat "$file"; done'
collect 'tcp-conn-req-max-q' 'ndd /dev/tcp tcp_conn_req_max_q'
collect 'tcp-conn-req-max-q0' 'ndd /dev/tcp tcp_conn_req_max_q0'
collect 'tcp-strong-iss' 'ndd /dev/tcp tcp_strong_iss'
collect 'tcp_rev_src_routes' 'ndd /dev/tcp tcp_rev_src_routes'
collect 'uname-a' 'uname -a'
if [ "$COLLECT" = 1 ]; then printf "Searching for unowned files..."; fi
collect 'unowned-files' 'find / \( -fstype nfs -o -fstype cachefs -o -fstype ctfs -o -fstype mntfs -o -fstype objfs -o -fstype proc \) -prune -o \( -nouser -o -nogroup \) -ls'
if [ "$COLLECT" = 1 ]; then echo; fi
collect 'usr-sys-resources' 'for F in /usr/dt/config/*/sys.resources; do echo "___ $F ___"; egrep "dtsession\*(saver|lock)Timeout" $F; done'
if [ "$COLLECT" = 1 ]; then printf "Searching for world writeable directories..."; fi
collect 'world-write-dir' 'find / \( -fstype nfs -o -fstype cachefs -o -fstype ctfs -o -fstype mntfs -o -fstype objfs -o -fstype proc \) -prune -o -type d \( -perm -0002 -a ! -perm -1000 \) -ls'
if [ "$COLLECT" = 1 ]; then echo; fi
if [ "$COLLECT" = 1 ]; then printf "Searching for world writeable files..."; fi
collect 'world-write-file' 'find / \( -fstype nfs -o -fstype cachefs -o -fstype ctfs -o -fstype mntfs -o -fstype objfs -o -fstype proc \) -prune -o -type f -perm -0002 -ls'
if [ "$COLLECT" = 1 ]; then echo; fi
collect 'audit_control' 'cat /etc/security/audit_control'
collect 'audit_event' 'cat /etc/security/audit_event'
collect 'audit_startup' 'cat /etc/security/audit_startup'
collect 'audit_user' 'cat /etc/security/audit_user'
collect 'gdm-config-simple-greeter' 'gconftool-2 -R /apps/gdm/simple-greeter'
collect 'grub.conf' 'bootadm list-menu > /dev/null && cat `bootadm list-menu | head -1 | cut -d '\'':'\'' -f 2`'
collect 'grub.conf-file' 'echo `bootadm list-menu | head -1 | cut -d '\'':'\'' -f 2`'
collect 'ls-grub.conf' 'ls -lndL `bootadm list-menu | head -1 | cut -d '\'':'\'' -f 2`'

if [ "$COLLECT" = 1 ]; then
	echo "----- END SURECHECK -----" >> $OUTPUT
	gzip $OUTPUT
	echo "Results in $OUTPUT.gz"
fi
