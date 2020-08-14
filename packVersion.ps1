$version = '3.11.0'

$checksumUrl = 'https://s3.eu-central-1.amazonaws.com/stack-v1/builds/prod/win/x64/Stack%20Setup%20' + $version + '-x64.exe'

Import-Module BitsTransfer
Start-BitsTransfer -Source $checksumUrl -Destination "Stack.exe"

$checksum   = (Get-FileHash -Path "Stack.exe" -Algorithm SHA256).Hash

Write-Host $checksum

Read-Host ‚Press Enter to continue…‘ | Out-Null