using namespace Belin.Validation

<#
.SYNOPSIS
	Creates a new `Equal` validator.
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

	return [ComparisonValidator[object]]@{
		Reason = $Reason
		Test = $CaseSensitive ? { $_ -ceq $this.ValueToCompare } : { $_ -ieq $this.ValueToCompare }
		ValueToCompare = $Value
	}
}

<#
.SYNOPSIS
	Creates a new `NotEqual` validator.
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

	return [ComparisonValidator[object]]@{
		Reason = $Reason
		Test = $CaseSensitive ? { $_ -cne $this.ValueToCompare } : { $_ -ine $this.ValueToCompare }
		ValueToCompare = $Value
	}
}
