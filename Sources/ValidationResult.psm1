using module ./ValidationFailure.psm1

<#
.SYNOPSIS
	The result of running a validator.
#>
[NoRunspaceAffinity()]
class ValidationResult {

	<#
	.SYNOPSIS
		The list of errors that occurred.
	#>
	[ValidateNotNull()]
	[ValidationFailure[]] $Errors

	<#
	.SYNOPSIS
		Creates a new validation result.
	#>
	ValidationResult() {
		$this.Errors = @()
	}

	<#
	.SYNOPSIS
		Creates a new validation result.
	.PARAMETER Errors
		The list of errors that occurred.
	#>
	ValidationResult([ValidationFailure[]] $Errors) {
		$this.Errors = $Errors
	}

	<#
	.SYNOPSIS
		Gets a value indicating whether the validation succeeded.
	.OUTPUTS
		`$true` if the validation succeeded, otherwise `$false`.
	#>
	[bool] IsValid() {
		return -not $this.Errors
	}

	<#
	.SYNOPSIS
		Returns a string representation of the error messages.
	.OUTPUTS
		The string representation of the error messages.
	#>
	[string] ToString() {
		return $this.ToString([Environment]::NewLine)
	}

	<#
	.SYNOPSIS
		Returns a string representation of the error messages.
	.PARAMETER Separator
		The string used to separate the error messages.
	.OUTPUTS
		The string representation of the error messages.
	#>
	[string] ToString([string] $Separator) {
		return $this.Errors -join $Separator
	}
}
