using namespace System.Collections
using namespace System.Collections.Generic

<#
.SYNOPSIS
	The unique instance of the `Empty` validator.
#>
[scriptblock] $Script:EmptyValidator = { param ([object] $property)
	if ($property -is [string]) { return [string]::IsNullOrWhiteSpace($property) }
	if ($property -is [ICollection]) { return $property.Count -eq 0 }
	if ($property -is [IEnumerable]) { return -not $property.GetEnumerator().MoveNext() }
	-not [bool] $property
}

<#
.SYNOPSIS
	The unique instance of the `NotEmpty` validator.
#>
[scriptblock] $Script:NotEmptyValidator = { param ([object] $property)
	if ($property -is [string]) { return -not [string]::IsNullOrWhiteSpace($property) }
	if ($property -is [ICollection]) { return $property.Count -gt 0 }
	if ($property -is [IEnumerable]) { return $property.GetEnumerator().MoveNext() }
	[bool] $property
}

<#
.SYNOPSIS
	Creates a new `Empty` validator.
.OUTPUTS
	The script block to use for validation.
#>
function New-ValidatorEmpty {
	[CmdletBinding()]
	[OutputType([scriptblock])]
	param ()

	$Script:EmptyValidator
}

<#
.SYNOPSIS
	Creates a new `NotEmpty` validator.
.OUTPUTS
	The script block to use for validation.
#>
function New-ValidatorNotEmpty {
	[CmdletBinding()]
	[OutputType([scriptblock])]
	param ()

	$Script:NotEmptyValidator
}
