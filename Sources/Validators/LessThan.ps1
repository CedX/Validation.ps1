using namespace Belin.Validation

<#
.SYNOPSIS
	Creates a new validator that ensures the validated value is less than a specific value.
.OUTPUTS
	The newly created validator.
#>
function New-ValidatorLessThan {
	[CmdletBinding()]
	[OutputType([Belin.Validation.Validator])]
	param (
		# The value to compare.
		[Parameter(Mandatory, Position = 0)]
		[AllowEmptyString()]
		[AllowNull()]
		[object] $Value,

		# The error message describing the validation failure.
		[Parameter(Mandatory, Position = 1)]
		[string] $Reason,

		# Value indicating whether to perform a case-sensitive comparison.
		[switch] $CaseSensitive
	)

	return [ComparisonValidator]@{
		Reason = $Reason
		Test = $CaseSensitive ? { $_ -clt $this.Value } : { $_ -ilt $this.Value }
		Value = $Value
	}
}

<#
.SYNOPSIS
	Creates a new validator that ensures the validated value is less than or equal to a specific value.
.OUTPUTS
	The newly created validator.
#>
function New-ValidatorLessThanOrEqual {
	[CmdletBinding()]
	[OutputType([Belin.Validation.Validator])]
	param (
		# The value to compare.
		[Parameter(Mandatory, Position = 0)]
		[AllowEmptyString()]
		[AllowNull()]
		[object] $Value,

		# The error message describing the validation failure.
		[Parameter(Mandatory, Position = 1)]
		[string] $Reason,

		# Value indicating whether to perform a case-sensitive comparison.
		[switch] $CaseSensitive
	)

	return [ComparisonValidator]@{
		Reason = $Reason
		Test = $CaseSensitive ? { $_ -cle $this.Value } : { $_ -ile $this.Value }
		Value = $Value
	}
}
