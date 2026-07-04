using namespace Belin.Validation

<#
.SYNOPSIS
	Creates a new validator that ensures a number falls within a specified range.
.OUTPUTS
	The newly created validator.
#>
function New-ValidatorRange {
	[CmdletBinding()]
	[OutputType([Belin.Validation.Validator])]
	param (
		# The minimum value of the range allowed.
		[Parameter(Mandatory, Position = 0)]
		[object] $From,

		# The maximum value of the range allowed.
		[Parameter(Mandatory, Position = 1)]
		[object] $To,

		# The error message describing the validation failure.
		[Parameter(Mandatory, Position = 2)]
		[string] $Reason,

		# Value indicating whether the specified range is exclusive.
		[switch] $Exclusive
	)

	if ($To -lt $From) {
		throw [ArgumentOutOfRangeException]::new("To", "The maximum value is less than the minimum value.")
	}

	return [RangeValidator]@{
		LowerBound = $From
		Reason = $Reason
		Test = $Exclusive ? { ($_ -gt $this.LowerBound) -and ($_ -lt $this.UpperBound) } : { ($_ -ge $this.LowerBound) -and ($_ -le $this.UpperBound) }
		UpperBound = $To
	}
}
