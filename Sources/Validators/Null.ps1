using module ../Validator.psm1

<#
.SYNOPSIS
	The unique instance of the `Null` validation script block.
#>
[scriptblock] $Script:NullValidator =

<#
.SYNOPSIS
	The unique instance of the `NotNull` validation script block.
#>
[scriptblock] $Script:NotNullValidator =

<#
.SYNOPSIS
	Creates a new `Null` validator.
.OUTPUTS
	The newly created validator.
#>
function New-ValidatorNull {
	[CmdletBinding()]
	[OutputType([Validator])]
	param (
		# The error message describing the validation failure.
		[Parameter(Position = 0)]
		[string] $ErrorMessage
	)

	$ErrorMessage ??= "'{PropertyName}' must be empty."
	[Validator]::new($ErrorMessage, { param ([object] $property)
		$null -eq $property
	})
}

<#
.SYNOPSIS
	Creates a new `NotNull` validator.
.OUTPUTS
	The newly created validator.
#>
function New-ValidatorNotNull {
	[CmdletBinding()]
	[OutputType([Validator])]
	param (
		# The error message describing the validation failure.
		[Parameter(Position = 0)]
		[string] $ErrorMessage
	)

	$ErrorMessage ??= "'{PropertyName}' must not be empty."
	[Validator]::new($ErrorMessage, { param ([object] $property)
		$null -ne $property
	})
}
