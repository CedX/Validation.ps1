using namespace System.Diagnostics.CodeAnalysis

<#
.SYNOPSIS
	Gets the project version number.
.OUTPUTS
	The project version number.
#>
function Get-Version {
	[CmdletBinding()]
	[OutputType([version])]
	param ()
	[version] (Import-PowerShellDataFile Validation.psd1).ModuleVersion
}

<#
.SYNOPSIS
	Publishes the solution to the PowerShell Gallery registry.
#>
function Publish-PSGalleryModule {
	$root = Join-Path $PSScriptRoot .. -Resolve
	$module = Import-PowerShellDataFile $root/Validation.psd1

	$output = "$root/Temp/PSModule"
	New-Item $output/Binaries -ItemType Directory | Out-Null
	Copy-Item $root/Validation.psd1 $output/Belin.Validation.psd1
	Copy-Item $root/*.md $output
	$module.RootModule | ForEach-Object { "$root/$_" } | Copy-Item -Destination $output/Binaries

	$output = "$root/Temp/PSGallery"
	New-Item $output -ItemType Directory | Out-Null
	Compress-PSResource $root/Temp/PSModule $output
	Get-Item $output/*.nupkg | ForEach-Object { Publish-PSResource -ApiKey $Env:PSGALLERY_API_KEY -NupkgPath $_ -Repository PSGallery }
}

<#
.SYNOPSIS
	Checks whether an update is available for the specified PowerShell module.
.INPUTS
	The PowerShell module to be checked.
.OUTPUTS
	An object providing the current and the latest version of the specified module if an update is available, otherwise none.
#>
function Test-PSResourceUpdate {
	[CmdletBinding()]
	[OutputType([psobject])]
	param (
		# The PowerShell module to be checked.
		[Parameter(Mandatory, Position = 1, ValueFromPipeline)]
		[Microsoft.PowerShell.PSResourceGet.UtilClasses.PSResourceInfo] $InputObject
	)

	process {
		if ($InputObject.Repository -ne "PSGallery") { return }

		$url = "https://www.powershellgallery.com/packages/$($InputObject.Name)"
		$response = Invoke-WebRequest $url -Method Head -MaximumRedirection 0 -SkipHttpErrorCheck -ErrorAction Ignore
		$latestVersion = [version] (Split-Path $response.Headers.Location -Leaf)

		$module = [pscustomobject]@{ ModuleName = $InputObject.Name; CurrentVersion = $InputObject.Version; LatestVersion = $latestVersion }
		if ($module.LatestVersion -gt $module.CurrentVersion) { $module }
	}
}
