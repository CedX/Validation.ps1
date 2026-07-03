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
		# The minimum length.
		[Parameter(Mandatory, Position = 0)]
		[ValidateRange("NonNegative")]
		[int] $MinLength,

		# The maximum length.
		[Parameter(Mandatory, Position = 1)]
		[ValidateRange("NonNegative")]
		[int] $MaxLength,

		# The error message describing the validation failure.
		[Parameter(Mandatory, Position = 2)]
		[string] $Reason
	)

	if ($MinLength -gt $MaxLength) {
		throw [ArgumentOutOfRangeException]::new("MinLength", "The minimum length is greater than the maximum length.")
	}

	return [RangeValidator[int]]@{
		LowerBound = $MinLength
		Reason = $Reason
		Test = { ($_.Length -ge $this.LowerBound) -and ($_.Length -le $this.UpperBound) }
		UpperBound = $MaxLength
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
		# The value to compare.
		[Parameter(Mandatory, Position = 0)]
		[ValidateRange("NonNegative")]
		[int] $Value,

		# The error message describing the validation failure.
		[Parameter(Mandatory, Position = 1)]
		[string] $Reason
	)

	return [ComparisonValidator[int]]@{
		Reason = $Reason
		Test = { $_.Length -le $this.Value }
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
		# The value to compare.
		[Parameter(Mandatory, Position = 0)]
		[ValidateRange("NonNegative")]
		[int] $Value,

		# The error message describing the validation failure.
		[Parameter(Mandatory, Position = 1)]
		[string] $Reason
	)

	return [ComparisonValidator[int]]@{
		Reason = $Reason
		Test = { $_.Length -ge $this.Value }
		Value = $Value
	}
}
