using module ./Tools.psm1

if ($Release) { & "$PSScriptRoot/Default.ps1" }
else { "The ""-Release"" switch must be set!"; exit 1 }

Write-Information "Publishing the package..."
$version = (Import-PowerShellDataFile Validation.psd1).ModuleVersion
New-GitTag "v$version"
Publish-PSGalleryModule
