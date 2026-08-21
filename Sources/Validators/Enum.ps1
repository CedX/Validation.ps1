<#
.SYNOPSIS
	Creates a new validator that ensures the validated value exists in a specified enumeration.
.OUTPUTS
	The newly created validator.
#>
function New-ValidatorEnum {
	[CmdletBinding()]
	[OutputType([Belin.Validation.Validator])]
	param (
		# An enumeration type.
		[Parameter(Mandatory, Position = 1)]
		[Type] $Type,

		# The error message describing the validation failure.
		[Parameter(Mandatory, Position = 2)]
		[string] $Reason
	)

	New-Validator $Reason { [Enum]::IsDefined($Type, $_) }
}
