using namespace Belin.Validation
using namespace IbanNet

<#
.SYNOPSIS
	Creates a new validator that ensures the validated value is a valid IBAN (international bank account number).
.OUTPUTS
	The newly created validator.
#>
function New-ValidatorIban {
	[CmdletBinding()]
	[OutputType([Belin.Validation.Validator])]
	param (
		# The error message describing the validation failure.
		[Parameter(Mandatory, Position = 1)]
		[string] $Reason
	)

	New-Validator $Reason { ($_ -is [string]) -and [IbanValidator]::new().Validate($_).IsValid }
}
