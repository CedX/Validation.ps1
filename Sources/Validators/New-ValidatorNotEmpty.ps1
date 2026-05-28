using namespace System.Collections
using namespace System.Collections.Generic

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

	{ param ([object] $value)
		if ($value -is [string]) { return -not [string]::IsNullOrWhiteSpace($value) }
		if ($value -is [ICollection]) { return $value.Count }
		if ($value -is [IEnumerable]) { return $value.GetEnumerator().MoveNext() }
		return [bool] $value
	}
}
