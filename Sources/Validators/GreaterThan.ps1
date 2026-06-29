using namespace Belin.Validation

<#
.SYNOPSIS
	Creates a new `GreaterThan` validator.
.OUTPUTS
	The newly created validator.
#>
function New-ValidatorGreaterThan {
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
		Test = $CaseSensitive ? { $_ -cgt $this.ValueToCompare } : { $_ -igt $this.ValueToCompare }
		ValueToCompare = $Value
	}
}

<#
.SYNOPSIS
	Creates a new `GreaterThanOrEqual` validator.
.OUTPUTS
	The newly created validator.
#>
function New-ValidatorGreaterThanOrEqual {
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
		Test = $CaseSensitive ? { $_ -cge $this.ValueToCompare } : { $_ -ige $this.ValueToCompare }
		ValueToCompare = $Value
	}
}
