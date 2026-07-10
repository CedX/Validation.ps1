using namespace Belin.Validation

<#
.SYNOPSIS
	Creates a new validator that ensures a string length falls within a specified range.
.OUTPUTS
	The newly created validator.
#>
function New-ValidatorLength {
	[CmdletBinding()]
	[OutputType([Belin.Validation.RangeValidator])]
	param (
		# The minimum required length.
		[Parameter(Mandatory, Position = 1)]
		[ValidateRange("NonNegative")]
		[int] $Min,

		# The maximum required length.
		[Parameter(Mandatory, Position = 2)]
		[ValidateRange("NonNegative")]
		[int] $Max,

		# The error message describing the validation failure.
		[Parameter(Mandatory, Position = 3)]
		[string] $Reason
	)

	if ($Max -lt $Min) {
		throw [ArgumentOutOfRangeException]::new("Max", "The maximum length is less than the minimum length.")
	}

	[RangeValidator]@{
		LowerBound = $Min
		Reason = $Reason
		Test = { ($_ -is [string]) -and ($_.Length -ge $this.LowerBound) -and ($_.Length -le $this.UpperBound) }
		UpperBound = $Max
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
	[OutputType([Belin.Validation.ComparisonValidator])]
	param (
		# The maximum required length.
		[Parameter(Mandatory, Position = 1)]
		[ValidateRange("NonNegative")]
		[int] $Value,

		# The error message describing the validation failure.
		[Parameter(Mandatory, Position = 2)]
		[string] $Reason
	)

	[ComparisonValidator]@{
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
	[OutputType([Belin.Validation.ComparisonValidator])]
	param (
		# The minimum required length.
		[Parameter(Mandatory, Position = 1)]
		[ValidateRange("NonNegative")]
		[int] $Value,

		# The error message describing the validation failure.
		[Parameter(Mandatory, Position = 2)]
		[string] $Reason
	)

	[ComparisonValidator]@{
		Reason = $Reason
		Test = { ($_ -is [string]) -and ($_.Length -ge $this.Value) }
		Value = $Value
	}
}
