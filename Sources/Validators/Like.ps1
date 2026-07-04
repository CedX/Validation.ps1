using namespace Belin.Validation

<#
.SYNOPSIS
	Creates a new validator that ensures the validated value matches a given wildcard pattern.
.OUTPUTS
	The newly created validator.
#>
function New-ValidatorLike {
	[CmdletBinding()]
	[OutputType([Belin.Validation.Validator])]
	param (
		# The pattern to match.
		[Parameter(Mandatory, Position = 0)]
		[string] $Pattern,

		# The error message describing the validation failure.
		[Parameter(Mandatory, Position = 1)]
		[string] $Reason,

		# Value indicating whether to perform a case-sensitive comparison.
		[switch] $CaseSensitive
	)

	return [ComparisonValidator]@{
		Reason = $Reason
		Test = $CaseSensitive ? { $_ -clike $this.Value } : { $_ -ilike $this.Value }
		Value = $Pattern
	}
}

<#
.SYNOPSIS
	Creates a new validator that ensures the validated value does not match a given wildcard pattern.
.OUTPUTS
	The newly created validator.
#>
function New-ValidatorNotLike {
	[CmdletBinding()]
	[OutputType([Belin.Validation.Validator])]
	param (
		# The pattern to match.
		[Parameter(Mandatory, Position = 0)]
		[string] $Pattern,

		# The error message describing the validation failure.
		[Parameter(Mandatory, Position = 1)]
		[string] $Reason,

		# Value indicating whether to perform a case-sensitive comparison.
		[switch] $CaseSensitive
	)

	return [ComparisonValidator]@{
		Reason = $Reason
		Test = $CaseSensitive ? { $_ -cnotlike $this.Value } : { $_ -inotlike $this.Value }
		Value = $Pattern
	}
}
