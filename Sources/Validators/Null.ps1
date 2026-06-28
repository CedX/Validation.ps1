using namespace Belin.Validation

<#
.SYNOPSIS
	Creates a new `Null` validator.
.OUTPUTS
	The newly created validator.
#>
function New-ValidatorNull {
	[CmdletBinding()]
	[OutputType([Belin.Validation.Validator])]
	param (
		# The error message describing the validation failure.
		[Parameter(Mandatory, Position = 0)]
		[string] $Reason
	)

	New-Validator $Reason { $null -eq $_ }
}

<#
.SYNOPSIS
	Creates a new `NotNull` validator.
.OUTPUTS
	The newly created validator.
#>
function New-ValidatorNotNull {
	[CmdletBinding()]
	[OutputType([Belin.Validation.Validator])]
	param (
		# The error message describing the validation failure.
		[Parameter(Mandatory, Position = 0)]
		[string] $Reason
	)

	New-Validator $Reason { $null -ne $_ }
}
