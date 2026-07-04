using namespace Belin.Validation

<#
.SYNOPSIS
	Creates a new validator that ensures the validated value is equal to a specific value.
.OUTPUTS
	The newly created validator.
#>
function New-ValidatorEqual {
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
		Test = $CaseSensitive ? { $_ -ceq $this.Value } : { $_ -ieq $this.Value }
		Value = $Value
	}
}

<#
.SYNOPSIS
	Creates a new validator that ensures the validated value is not equal to a specific value.
.OUTPUTS
	The newly created validator.
#>
function New-ValidatorNotEqual {
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
		Test = $CaseSensitive ? { $_ -cne $this.Value } : { $_ -ine $this.Value }
		Value = $Value
	}
}
