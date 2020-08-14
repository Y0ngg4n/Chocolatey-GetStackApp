$version = '3.11.0'

$checksumUrl = 'https://s3.eu-central-1.amazonaws.com/stack-v1/builds/prod/win/x64/Stack%20Setup%20' + $version + '-x64.exe'

Import-Module BitsTransfer
Start-BitsTransfer -Source $checksumUrl -Destination "Stack.exe"

$checksum   = (Get-FileHash -Path "Stack.exe" -Algorithm SHA256).Hash

(Get-Content tools/chocolateyinstall.ps1) `
    -replace '#REPLACE_VERSION#', $version |
  Out-File tools/chocolateyinstall.ps1

(Get-Content tools/chocolateyinstall.ps1) `
    -replace '#REPLACE_CHECKSUM#', $checksum `
    -replace '#REPLACE_CHECKSUM_64#', $checksum |
  Out-File tools/chocolateyinstall.ps1

(Get-Content getstack-app.nuspec) `
    -replace '#REPLACE_VERSION#', $version |
Out-File getstack-app.nuspec

choco pack

(Get-Content tools/chocolateyinstall.ps1) `
    -replace $version, '#REPLACE_VERSION#' |
  Out-File tools/chocolateyinstall.ps1

(Get-Content tools/chocolateyinstall.ps1) `
    -replace $checksum, '#REPLACE_CHECKSUM#' `
    -replace $checksum, '#REPLACE_CHECKSUM_64#' |
  Out-File tools/chocolateyinstall.ps1

(Get-Content getstack-app.nuspec) `
    -replace $version, '#REPLACE_VERSION#' |
Out-File getstack-app.nuspec