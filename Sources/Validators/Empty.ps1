using namespace System.Collections
using namespace System.Collections.Generic
using module ../Validator.psm1

<#
.SYNOPSIS
	Creates a new `Empty` validator.
.OUTPUTS
	The newly created validator.
#>
function New-ValidatorEmpty {
	[CmdletBinding()]
	[OutputType([Validator])]
	param (
		# The error message describing the validation failure.
		[Parameter(Position = 0)]
		[string] $ErrorMessage
	)

	$ErrorMessage ??= "'{PropertyName}' must be empty."
	[Validator]::new($ErrorMessage, { param ([object] $object)
		if ($object -is [string]) { return [string]::IsNullOrWhiteSpace($object) }
		if ($object -is [ICollection]) { return $object.Count -eq 0 }
		if ($object -is [IEnumerable]) { return -not $object.GetEnumerator().MoveNext() }
		-not [bool] $object
	})
}

<#
.SYNOPSIS
	Creates a new `NotEmpty` validator.
.OUTPUTS
	The newly created validator.
#>
function New-ValidatorNotEmpty {
	[CmdletBinding()]
	[OutputType([Validator])]
	param (
		# The error message describing the validation failure.
		[Parameter(Position = 0)]
		[string] $ErrorMessage
	)

	$ErrorMessage ??= "'{PropertyName}' must not be empty."
	[Validator]::new($ErrorMessage, { param ([object] $object)
		if ($object -is [string]) { return -not [string]::IsNullOrWhiteSpace($object) }
		if ($object -is [ICollection]) { return $object.Count -gt 0 }
		if ($object -is [IEnumerable]) { return $object.GetEnumerator().MoveNext() }
		[bool] $object
	})
}
