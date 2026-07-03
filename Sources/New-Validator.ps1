using namespace Belin.Validation

<#
.SYNOPSIS
	Creates a new validator.
.OUTPUTS
	The newly created validator.
#>
function New-Validator {
	[CmdletBinding()]
	[OutputType([Belin.Validation.Validator])]
	param (
		# The error message describing the validation failure.
		[Parameter(Mandatory, Position = 0)]
		[string] $Reason,

		# The script block used to perform the validation.
		[Parameter(Mandatory, Position = 1)]
		[scriptblock] $Test
	)

	return [Validator]@{
		Reason = $Reason
		Test = $Test
	}
}
