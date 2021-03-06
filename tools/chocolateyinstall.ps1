$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$version = '3.11.0'

$checksum   = "749013F8DD3A742F795A4023B1E6674A84BA8923BE422A1292AC6A35EE3A7460"
$checksum64 = "749013F8DD3A742F795A4023B1E6674A84BA8923BE422A1292AC6A35EE3A7460"

Write-Output "Checksums for Version $version"
Write-Output "$checksum"
Write-Output "$checksum64"

$url        = 'https://s3.eu-central-1.amazonaws.com/stack-v1/builds/prod/win/x64/Stack%20Setup%20' + $version + '-x64.exe'
$url64      = 'https://s3.eu-central-1.amazonaws.com/stack-v1/builds/prod/win/x64/Stack%20Setup%20' + $version + '-x64.exe'

$pp = Get-PackageParameters
 
$parameters += if ($pp.NoDesktopShortcut)     { " /desktopshortcut=0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut)     { " /pintotaskbar=0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  url64bit      = $url64

  silentArgs     = $parameters

  softwareName  = 'stack*'

  checksum      = $checksum
  checksumType  = 'sha256'
  checksum64    = $checksum64
  checksumType64= 'sha256'

  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
