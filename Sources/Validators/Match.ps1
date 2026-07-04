using namespace Belin.Validation

<#
.SYNOPSIS
	Creates a new validator that ensures the validated value matches a given regex pattern.
.OUTPUTS
	The newly created validator.
#>
function New-ValidatorMatch {
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
		Test = $CaseSensitive ? { $_ -cmatch $this.Value } : { $_ -imatch $this.Value }
		Value = $Pattern
	}
}

<#
.SYNOPSIS
	Creates a new validator that ensures the validated value does not match a given regex pattern.
.OUTPUTS
	The newly created validator.
#>
function New-ValidatorNotMatch {
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
		Test = $CaseSensitive ? { $_ -cnotmatch $this.Value } : { $_ -inotmatch $this.Value }
		Value = $Pattern
	}
}
