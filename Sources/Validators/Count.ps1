using namespace Belin.Validation

<#
.SYNOPSIS
	Creates a new validator that ensures a collection length falls within a specified range.
.OUTPUTS
	The newly created validator.
#>
function New-ValidatorCount {
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
		Test = { ($_.Count -ge $this.LowerBound) -and ($_.Count -le $this.UpperBound) }
		UpperBound = $Max
	}
}

<#
.SYNOPSIS
	Creates a new validator that ensures the validated value has a maximum length.
.OUTPUTS
	The newly created validator.
#>
function New-ValidatorMaxCount {
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
		Test = { $_.Count -le $this.Value }
		Value = $Value
	}
}

<#
.SYNOPSIS
	Creates a new validator that ensures the validated value has a minimum length.
.OUTPUTS
	The newly created validator.
#>
function New-ValidatorMinCount {
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
		Test = { $_.Count -ge $this.Value }
		Value = $Value
	}
}
