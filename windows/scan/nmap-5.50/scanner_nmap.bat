ECHO OFF


ECHO Nmap - Ping
nmap.exe -vvv -T5 -n -sP -oA nmap_ping %1

ECHO Nmap - TCP Port Scan top 50 (no ping)
nmap.exe -vvv --min-rate 400 --min-parallelism 100 --min-hostgroup=257 -Pn -n -T4 --open -p 21-23,25-26,53,80-81,110-111,113,134-139,143,179,199,443,445,465,512-515,548,554,587,993,995,1025-1026,1433,1434,1720,1723,2000-2001,2049,3306,3389,5060,5432,5900,5901,6001,8000,8080,8081,8443,8888,10000,15432,32768,49152 -oA nmap_tcp_noping %1

ECHO Nmap - UDP Port Scan top 10 (no ping)
nmap.exe -vvv --min-rate 400 --min-parallelism 100 --min-hostgroup=257 -Pn -sU -n -T4 --open -p53,67,123,135,137-138,161,445,631,1434 -oA nmap_udp_noping %1

ECHO Nmap - FULL TCP Port Scan
nmap.exe -vvv --min-hostgroup=257 -sT -n -T4 -p- -oA nmap_tcp_full %1