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
	[Validator]::new($ErrorMessage, { param ([object] $property)
		if ($property -is [string]) { return [string]::IsNullOrWhiteSpace($property) }
		if ($property -is [ICollection]) { return $property.Count -eq 0 }
		if ($property -is [IEnumerable]) { return -not $property.GetEnumerator().MoveNext() }
		-not [bool] $property
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
	[Validator]::new($ErrorMessage, { param ([object] $property)
		if ($property -is [string]) { return -not [string]::IsNullOrWhiteSpace($property) }
		if ($property -is [ICollection]) { return $property.Count -gt 0 }
		if ($property -is [IEnumerable]) { return $property.GetEnumerator().MoveNext() }
		[bool] $property
	})
}
