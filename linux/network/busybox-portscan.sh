
#!/bin/bash

# 


export BUSYBOXPATH="./busybox"

if [ -z "$1" ] ; then
	echo "$0 [IP] [PORTS]"
	echo ""
	echo "EXAMPLE"
	echo "$0 192.168.80 22,445,3389,5985"
else
	if [ -z "$2" ]; then	
		export PORTS="21,22,23,25,26,53,80,81,110,111,113,134,135,136,137,139,143,179,199,443,445,465,512,513,514,515,548,554,587,993,995,1025,1026,1433,1443,1434,1720,1723,2000,2001,2049,3306,3389,5060,5432,5900,5901,6000,6001,8000,8080,8081,8443,8888,10000,15432,32768,49152,5985"
	else
		export PORTS="$2"
	fi
	
	

for i in $(echo $PORTS | sed "s/,/ /g")
	do		
		if $BUSYBOXPATH nc -vv -z $1 $i > /dev/null 2>/dev/null; then
			echo "$1:$i"
		#else
			#	echo "$1.$x:$i		closed"
		fi
	done	
	
fi
