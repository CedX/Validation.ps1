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

	return [ComparisonValidator[object]]@{
		Reason = $Reason
		Test = $CaseSensitive ? { $_ -clt $this.ValueToCompare } : { $_ -ilt $this.ValueToCompare }
		ValueToCompare = $Value
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

	return [ComparisonValidator[object]]@{
		Reason = $Reason
		Test = $CaseSensitive ? { $_ -cle $this.ValueToCompare } : { $_ -ile $this.ValueToCompare }
		ValueToCompare = $Value
	}
}
