<#
.SYNOPSIS
	Creates a new `GreaterThan` validator.
.OUTPUTS
	The script block to use for validation.
#>
function New-ValidatorGreaterThan {
	[CmdletBinding()]
	[OutputType([scriptblock])]
	param (
		# The value to compare.
		[Parameter(Mandatory, Position = 0, ValueFromPipeline)]
		[AllowEmptyCollection()]
		[AllowEmptyString()]
		[AllowNull()]
		[object] $Value
	)

	process {
		{ param ([object] $property) $property -gt $Value }
	}
}

<#
.SYNOPSIS
	Creates a new `GreaterThanOrEqual` validator.
.OUTPUTS
	The script block to use for validation.
#>
function New-ValidatorGreaterThanOrEqual {
	[CmdletBinding()]
	[OutputType([scriptblock])]
	param (
		# The value to compare.
		[Parameter(Mandatory, Position = 0, ValueFromPipeline)]
		[AllowEmptyCollection()]
		[AllowEmptyString()]
		[AllowNull()]
		[object] $Value
	)

	process {
		{ param ([object] $property) $property -ge $Value }
	}
}
