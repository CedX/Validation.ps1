using module ../Validator.psm1

<#
.SYNOPSIS
	Creates a new `GreaterThan` validator.
.OUTPUTS
	The newly created validator.
#>
function New-ValidatorGreaterThan {
	[CmdletBinding()]
	[OutputType([Validator])]
	param (
		# The value to compare.
		[Parameter(Mandatory, Position = 0)]
		[AllowEmptyCollection()]
		[AllowEmptyString()]
		[AllowNull()]
		[object] $Value,

		# The error message describing the validation failure.
		[Parameter(Position = 1)]
		[string] $ErrorMessage
	)

	$ErrorMessage ??= "'{PropertyName}' must be greater than '{ComparisonValue}'."
	[Validator]::new($ErrorMessage, @($Value), { param ([object] $property, [object] $comparisonValue)
		$property -gt $comparisonValue
	})
}

<#
.SYNOPSIS
	Creates a new `GreaterThanOrEqual` validator.
.OUTPUTS
	The newly created validator.
#>
function New-ValidatorGreaterThanOrEqual {
	[CmdletBinding()]
	[OutputType([Validator])]
	param (
		# The value to compare.
		[Parameter(Mandatory, Position = 0)]
		[AllowEmptyCollection()]
		[AllowEmptyString()]
		[AllowNull()]
		[object] $Value,

		# The error message describing the validation failure.
		[Parameter(Position = 1)]
		[string] $ErrorMessage
	)

	$ErrorMessage ??= "'{PropertyName}' must be greater than or equal to '{ComparisonValue}'."
	[Validator]::new($ErrorMessage, @($Value), { param ([object] $property, [object] $comparisonValue)
		$property -ge $comparisonValue
	})
}
