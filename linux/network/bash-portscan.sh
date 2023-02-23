
if [ -z "$1" ]; then 
	echo "$0 [IP] [PORTS]"
	echo ""
	echo "EXAMPLE"
	echo "$0 192.168.80.100 22,445,3389,5985"
else
	if [ -z "$2" ]; then
		export PORTS="80,445,3389,5985,445,22,21,23,25,53,110,111,135,512,513,514,2049,5432,1443,3306,5900,8080,8081"
	else
		export PORTS=$2
	
	fi

	for i in $(echo $PORTS | sed "s/,/ /g")
	do	
	
	echo  2> /dev/null > /dev/tcp/$1/$i
  [ $? == 0 ] && echo "$1:$i		open" #|| echo "$1:$i		closed"

	done
fi

