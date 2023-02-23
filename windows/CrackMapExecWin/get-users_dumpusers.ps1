$ProgressPreference = 'SilentlyContinue'	

$global:target=$args[0]

function cut {
  param(
    [Parameter(ValueFromPipeline=$True)] [string]$inputobject,
    [string]$delimiter='\s+',
    [string[]]$field
  )

  process {
    if ($field -eq $null) { $inputobject -split $delimiter } else {
      ($inputobject -split $delimiter)[$field] }
  }
}

function run-dumpusers {

$($(.\dumpusers.exe -target $target -type dc -start 300 -stop 2000 -mode verbose | findstr 'Account Name') -Split ':' | findstr /v 'Account name').trimstart(" ") | Select-String -NotMatch -Pattern " " | findstr /v \$  | cut -delimiter \\ -f 1 | Out-File -Encoding ascii users.txt

cat users.txt
}

if ($target) { 
run-dumpusers  
} else {
Write-Host "USEAGE: " 
Write-Host "	./get-dumpusers.ps1 [IP ADDRESS]" 
Write-Host "" 
Write-Host "" 
}





