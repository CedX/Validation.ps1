using namespace Belin.Validation

<#
.SYNOPSIS
	Creates a new validator that ensures the validated value is greater than a specific value.
.OUTPUTS
	The newly created validator.
#>
function New-ValidatorGreaterThan {
	[CmdletBinding()]
	[OutputType([Belin.Validation.ComparisonValidator])]
	param (
		# The value to compare.
		[Parameter(Mandatory, Position = 1)]
		[AllowEmptyString()]
		[AllowNull()]
		[object] $Value,

		# The error message describing the validation failure.
		[Parameter(Mandatory, Position = 2)]
		[string] $Reason,

		# Value indicating whether to perform a case-sensitive comparison.
		[switch] $CaseSensitive
	)

	[ComparisonValidator]@{
		Reason = $Reason
		Test = $CaseSensitive ? { $_ -cgt $this.Value } : { $_ -igt $this.Value }
		Value = $Value
	}
}

<#
.SYNOPSIS
	Creates a new validator that ensures the validated value is greater than or equal to a specific value.
.OUTPUTS
	The newly created validator.
#>
function New-ValidatorGreaterThanOrEqual {
	[CmdletBinding()]
	[OutputType([Belin.Validation.ComparisonValidator])]
	param (
		# The value to compare.
		[Parameter(Mandatory, Position = 1)]
		[AllowEmptyString()]
		[AllowNull()]
		[object] $Value,

		# The error message describing the validation failure.
		[Parameter(Mandatory, Position = 2)]
		[string] $Reason,

		# Value indicating whether to perform a case-sensitive comparison.
		[switch] $CaseSensitive
	)

	[ComparisonValidator]@{
		Reason = $Reason
		Test = $CaseSensitive ? { $_ -cge $this.Value } : { $_ -ige $this.Value }
		Value = $Value
	}
}
