<#
.SYNOPSIS
	Creates a new validator that ensures the validated value is a well-formed mail address.
.OUTPUTS
	The newly created validator.
#>
function New-ValidatorEmail {
	[CmdletBinding()]
	[OutputType([Belin.Validation.Validator])]
	param (
		# The error message describing the validation failure.
		[Parameter(Mandatory, Position = 0)]
		[string] $Reason
	)

	New-Validator $Reason {

	}
}
