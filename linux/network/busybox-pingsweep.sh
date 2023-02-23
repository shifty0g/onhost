
#!/bin/bash

# 


export BUSYBOXPATH="./busybox"

if [ -z "$1" ] ; then
	echo "$0 [IP]"
	echo ""
	echo "EXAMPLE"
	echo "$0 192.168.80"
else

	
	
for x in $(seq 0 255); do 
	if $BUSYBOXPATH ping -c1 -W1 $1.$x > /dev/null 2>/dev/null; then
		echo "$1.$x"
	#else
	#	echo "$1.$x		Dead"
	fi	 	 
done	
	
fi


