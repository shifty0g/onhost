
#!/bin/bash

# 80,445,3389,5985,445,22,21,23,25,53,110,111,135,512,513,514,2049,5432,1443,3306,5900,8080,8081


export SOCATPATH="./socat"

if [ -z "$1" ] || [ -z "$2" ]; then
	echo "$0 [IP] [PORTS]"
	echo ""
	echo "EXAMPLE"
	echo "$0 192.168.80.100 22,445,3389,5985"
else
	for i in $(echo $2 | sed "s/,/ /g")
	do	
		if $SOCATPATH -T2 - TCP4:$1:$i > /dev/null 2>/dev/null; then
			echo "$1:$i		open"
		else
			echo "$1:$i		closed"
		fi
	done
fi


