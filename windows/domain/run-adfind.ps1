# Runs a set of AD find commands and outputs the files 

$outdir="ad"

New-Item -ItemType Directory -Force -Path $outdir 

echo "[+] Users" 
.\AdFind.exe -f "&(objectClass=User)(objectCategory=Person)" > $outdir"\users_full.txt"
.\AdFind.exe -f objectCategory=Person -nodn -nolabel -q samaccountname | Tee $outdir"\users.txt"

echo "[+] Users - Descriptions + Manager " 
echo "SEP=," > $outdir"\users-desc.csv"
.\ADFind.exe -f "objectClass=user" samaccountname description manager -nodn -gcsv  > $outdir"\users-desc.csv"
cat $outdir"\users-desc.csv"  | select -Skip 1 > $outdir"\temp.csv"
$P = Import-Csv -Path $outdir"\temp.csv" -Delimiter ','
$P | Format-Table | Out-File -Width 9999 $outdir"\users-desc.txt"
cat $outdir"\users-desc.txt"
del $outdir"\temp.csv"

echo "[+] Users with managers" 
.\AdFind.exe -q -nodn -f manager=* name description manager | Tee $outdir"\user-managers.txt"

echo "[+] User - CSASuser"
.\AdFind.exe -f "&(samaccountname=CSASuser)" | Tee $outdir"\CSASuser.txt"

echo "[+] Computers" 
.\AdFind.exe -f objectCategory=Computer name -nodn -nolabel -q  | Tee $outdir"\computers.txt"
.\AdFind.exe -f objectCategory=Computer  > $outdir"\computers_full.txt"

echo "[+] trustdmp" 
.\AdFind.exe -sc trustdmp  | Tee $outdir"\trustdmp.txt"

echo "[+] subnets" 
.\AdFind.exe -subnets | Tee $outdir"\subnets.txt"

echo "[+] domainlist" 
.\AdFind.exe -sc domainlist  | Tee $outdir"\domainlist.txt"

echo "[+] dcmodes" 
.\AdFind.exe -sc dcmodes  | Tee $outdir"\dcmodes.txt"

echo "[+] adinfo" 
.\AdFind.exe -sc adinfo  | Tee $outdir"\adinfo.txt"

echo "[+] dclist" 
.\AdFind.exe -sc adinfo | Tee $outdir"\dclist.txt"