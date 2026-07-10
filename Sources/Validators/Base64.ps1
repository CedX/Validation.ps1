using namespace Belin.Validation
using namespace System.Buffers.Text

<#
.SYNOPSIS
	Creates a new validator that ensures the validated value is a well-formed Base64 string.
.OUTPUTS
	The newly created validator.
#>
function New-ValidatorBase64 {
	[CmdletBinding()]
	[OutputType([Belin.Validation.Validator])]
	param (
		# The error message describing the validation failure.
		[Parameter(Mandatory, Position = 1)]
		[string] $Reason,

		# Value indicating whether the specified string uses a URL-safe alphabet.
		[switch] $Url
	)

	New-Validator $Reason ($Url ? { ($_ -is [string]) -and [Base64Url]::IsValid($_) } : { ($_ -is [string]) -and [Base64]::IsValid($_) })
}
