<#
.SYNOPSIS
	The unique instance of the validator.
#>
[scriptblock] $Script:NotNullValidator = { param ([object] $property) $null -ne $property }

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

	$Script:NotNullValidator
}
