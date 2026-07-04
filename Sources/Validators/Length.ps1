using namespace Belin.Validation

<#
.SYNOPSIS
	Creates a new validator that ensures a string length falls within a specified range.
.OUTPUTS
	The newly created validator.
#>
function New-ValidatorLength {
	[CmdletBinding()]
	[OutputType([Belin.Validation.Validator])]
	param (
		# The minimum required length.
		[Parameter(Mandatory, Position = 0)]
		[ValidateRange("NonNegative")]
		[int] $Minimum,

		# The maximum required length.
		[Parameter(Mandatory, Position = 1)]
		[ValidateRange("NonNegative")]
		[int] $Maximum,

		# The error message describing the validation failure.
		[Parameter(Mandatory, Position = 2)]
		[string] $Reason
	)

	if ($Maximum -lt $Minimum) {
		throw [ArgumentOutOfRangeException]::new("Maximum", "The maximum length is less than the minimum length.")
	}

	return [RangeValidator[int]]@{
		LowerBound = $Minimum
		Reason = $Reason
		Test = { ($_ -is [string]) -and ($_.Length -ge $this.LowerBound) -and ($_.Length -le $this.UpperBound) }
		UpperBound = $Maximum
	}
}

<#
.SYNOPSIS
	Creates a new validator that ensures the validated string has a maximum length.
.OUTPUTS
	The newly created validator.
#>
function New-ValidatorMaxLength {
	[CmdletBinding()]
	[OutputType([Belin.Validation.Validator])]
	param (
		# The maximum required length.
		[Parameter(Mandatory, Position = 0)]
		[ValidateRange("NonNegative")]
		[int] $Value,

		# The error message describing the validation failure.
		[Parameter(Mandatory, Position = 1)]
		[string] $Reason
	)

	return [ComparisonValidator[int]]@{
		Reason = $Reason
		Test = { ($_ -is [string]) -and ($_.Length -le $this.Value) }
		Value = $Value
	}
}

<#
.SYNOPSIS
	Creates a new validator that ensures the validated string has a minimum length.
.OUTPUTS
	The newly created validator.
#>
function New-ValidatorMinLength {
	[CmdletBinding()]
	[OutputType([Belin.Validation.Validator])]
	param (
		# The minimum required length.
		[Parameter(Mandatory, Position = 0)]
		[ValidateRange("NonNegative")]
		[int] $Value,

		# The error message describing the validation failure.
		[Parameter(Mandatory, Position = 1)]
		[string] $Reason
	)

	return [ComparisonValidator[int]]@{
		Reason = $Reason
		Test = { ($_ -is [string]) -and ($_.Length -ge $this.Value) }
		Value = $Value
	}
}
