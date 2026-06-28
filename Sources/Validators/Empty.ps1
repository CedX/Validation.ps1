using namespace Belin.Validation
using namespace System.Collections
using namespace System.Collections.Generic

<#
.SYNOPSIS
	Creates a new `Empty` validator.
.OUTPUTS
	The newly created validator.
#>
function New-ValidatorEmpty {
	[CmdletBinding()]
	[OutputType([Belin.Validation.Validator])]
	param (
		# The error message describing the validation failure.
		[Parameter(Mandatory, Position = 0)]
		[string] $Reason
	)

	New-Validator $Reason {
		if ($_ -is [string]) { return [string]::IsNullOrWhiteSpace($_) }
		if ($_ -is [ICollection]) { return $_.Count -eq 0 }
		if ($_ -is [IEnumerable]) { return -not $_.GetEnumerator().MoveNext() }
		-not [bool] $_
	}
}

<#
.SYNOPSIS
	Creates a new `NotEmpty` validator.
.OUTPUTS
	The newly created validator.
#>
function New-ValidatorNotEmpty {
	[CmdletBinding()]
	[OutputType([Belin.Validation.Validator])]
	param (
		# The error message describing the validation failure.
		[Parameter(Mandatory, Position = 0)]
		[string] $Reason
	)

	New-Validator $Reason {
		if ($_ -is [string]) { return -not [string]::IsNullOrWhiteSpace($_) }
		if ($_ -is [ICollection]) { return $_.Count -gt 0 }
		if ($_ -is [IEnumerable]) { return $_.GetEnumerator().MoveNext() }
		[bool] $_
	}
}
