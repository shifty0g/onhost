#!/bin/bash

VAL=`uname -r`;

case "$VAL" in
	2.6.*) echo "Looks like kernel 2.6......"
            ./ip_append_data ;
            ./full-nelson ;
            ./hoagie_udpsendmsg ;
            ./k-rad3 ;
            ./linux-gate ;
            ./mcast_msfilter ;
            ./prctl_coredump ;
            ./prctlpute ;
            ./ptrace_pokeuser ;
            ./rds-privesc ;
            ./udev-141 ;
            ./vmsplice ;
            ./vmsplice2 ;
            ./vmsplice3 ;;
	2.4.*) echo Looks like kernel "2.4";
            ./mcast_msfilter ;
            ./ptrace_pokeuser ;;
    esac
