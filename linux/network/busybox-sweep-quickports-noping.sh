
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
		export PORTS="80,443,3389,5985,445,22,21,23,25,53,110,111,135,137,139,512,513,514,2049,5432,15432,1443,3306,5900,8080,5985,6000"
	else
		export PORTS="$2"
	fi
		
	
for x in $(seq 0 255); do 
	for i in $(echo $PORTS | sed "s/,/ /g")
		do		
			if $BUSYBOXPATH nc -vv -z $1.$x $i > /dev/null 2>/dev/null; then
				echo "$1.$x:$i"
			#else
			#	echo "$1.$x:$i		closed"
			fi
	done
done	
	
fi
echo "done"

