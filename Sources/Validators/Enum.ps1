using namespace Belin.Validation

<#
.SYNOPSIS
	Creates a new validator that ensures the validated value exists in a specified enumeration.
.OUTPUTS
	The newly created validator.
#>
function New-ValidatorEnum {
	[CmdletBinding()]
	[OutputType([Belin.Validation.ComparisonValidator])]
	param (
		# An enumeration type.
		[Parameter(Mandatory, Position = 1)]
		[Type] $Type,

		# The error message describing the validation failure.
		[Parameter(Mandatory, Position = 2)]
		[string] $Reason
	)

	[ComparisonValidator]@{
		Reason = $Reason
		Test = { [Enum]::IsDefined($this.Value, $_) }
		Value = $Type
	}
}
