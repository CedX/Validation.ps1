<#
.SYNOPSIS
	TODO
.OUTPUTS
	TODO
#>
function New-ValidatorNotNull {
	[CmdletBinding()]
	[OutputType([scriptblock])]
	param ()

	{ param ([object] $value)
		$null -ne $value
	}
}
