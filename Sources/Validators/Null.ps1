<#
.SYNOPSIS
	The unique instance of the `Null` validator.
#>
[scriptblock] $Script:NullValidator = { param ([object] $property) $null -eq $property }

<#
.SYNOPSIS
	The unique instance of the `NotNull` validator.
#>
[scriptblock] $Script:NotNullValidator = { param ([object] $property) $null -ne $property }

<#
.SYNOPSIS
	Creates a new `Null` validator.
.OUTPUTS
	The script block to use for validation.
#>
function New-ValidatorNull {
	[CmdletBinding()]
	[OutputType([scriptblock])]
	param ()

	$Script:NullValidator
}

<#
.SYNOPSIS
	Creates a new `NotNull` validator.
.OUTPUTS
	The script block to use for validation.
#>
function New-ValidatorNotNull {
	[CmdletBinding()]
	[OutputType([scriptblock])]
	param ()

	$Script:NotNullValidator
}
