$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$version = '#REPLACE_VERSION#'

$checksum   = "#REPLACE_CHECKSUM#"
$checksum64 = "#REPLACE_CHECKSUM#"

Write-Output "Checksums for Version $version"
Write-Output "$checksum"
Write-Output "$checksum64"

$url        = 'https://s3.eu-central-1.amazonaws.com/stack-v1/builds/prod/win/x64/Stack%20Setup%20' + $version + '-x64.exe'
$url64      = 'https://s3.eu-central-1.amazonaws.com/stack-v1/builds/prod/win/x64/Stack%20Setup%20' + $version + '-x64.exe'

$pp = Get-PackageParameters

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  url64bit      = $url64

  silentArgs     = '/install /silent' + $parameters

  softwareName  = 'stack*'

  checksum      = $checksum
  checksumType  = 'sha256'
  checksum64    = $checksum64
  checksumType64= 'sha256'

  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
