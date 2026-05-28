<#
.SYNOPSIS
	Creates a new validator.
.OUTPUTS
	The script block to use for validation.
#>
function New-ValidatorNotNull {
	[CmdletBinding()]
	[OutputType([scriptblock])]
	param ()

	{ param ([object] $value) $null -ne $value }
}
