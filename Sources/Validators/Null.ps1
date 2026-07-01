<#
.SYNOPSIS
	Creates a new validator that ensures the validated value is `$null`.
.OUTPUTS
	The newly created validator.
#>
function New-ValidatorNull {
	[CmdletBinding()]
	[OutputType([Belin.Validation.IValidator])]
	param (
		# The error message describing the validation failure.
		[Parameter(Mandatory, Position = 0)]
		[string] $Reason
	)

	New-Validator $Reason { $null -eq $_ }
}

<#
.SYNOPSIS
	Creates a new validator that ensures the validated value is not `$null`.
.OUTPUTS
	The newly created validator.
#>
function New-ValidatorNotNull {
	[CmdletBinding()]
	[OutputType([Belin.Validation.IValidator])]
	param (
		# The error message describing the validation failure.
		[Parameter(Mandatory, Position = 0)]
		[string] $Reason
	)

	New-Validator $Reason { $null -ne $_ }
}
