using namespace Belin.Validation

<#
.SYNOPSIS
	Creates a new validator that ensures the validated value matches an element from a set of possible values.
.OUTPUTS
	The newly created validator.
#>
function New-ValidatorIn {
	[CmdletBinding()]
	[OutputType([Belin.Validation.ComparisonValidator])]
	param (
		# The set of possible values.
		[Parameter(Mandatory, Position = 1)]
		[object[]] $Values,

		# The error message describing the validation failure.
		[Parameter(Mandatory, Position = 2)]
		[string] $Reason,

		# Value indicating whether to perform a case-sensitive comparison.
		[switch] $CaseSensitive
	)

	[ComparisonValidator]@{
		Reason = $Reason
		Test = $CaseSensitive ? { $_ -cin $this.Value } : { $_ -iin $this.Value }
		Value = $Values
	}
}

<#
.SYNOPSIS
	Creates a new validator that ensures the validated value does not match an element from a set of possible values.
.OUTPUTS
	The newly created validator.
#>
function New-ValidatorNotIn {
	[CmdletBinding()]
	[OutputType([Belin.Validation.ComparisonValidator])]
	param (
		# The set of possible values.
		[Parameter(Mandatory, Position = 1)]
		[object[]] $Values,

		# The error message describing the validation failure.
		[Parameter(Mandatory, Position = 2)]
		[string] $Reason,

		# Value indicating whether to perform a case-sensitive comparison.
		[switch] $CaseSensitive
	)

	[ComparisonValidator]@{
		Reason = $Reason
		Test = $CaseSensitive ? { $_ -cnotin $this.Value } : { $_ -inotin $this.Value }
		Value = $Values
	}
}
