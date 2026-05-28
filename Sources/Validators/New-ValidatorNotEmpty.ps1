using namespace System.Collections
using namespace System.Collections.Generic

<#
.SYNOPSIS
	The unique instance of the validator.
#>
[scriptblock] $Script:NotEmptyValidator = { param ([object] $property)
	if ($property -is [string]) { return -not [string]::IsNullOrWhiteSpace($property) }
	if ($property -is [ICollection]) { return $property.Count }
	if ($property -is [IEnumerable]) { return $property.GetEnumerator().MoveNext() }
	[bool] $property
}

<#
.SYNOPSIS
	Creates a new validator.
.OUTPUTS
	The script block to use for validation.
#>
function New-ValidatorNotEmpty {
	[CmdletBinding()]
	[OutputType([scriptblock])]
	param ()

	$Script:NotEmptyValidator
}
