<#
.SYNOPSIS
	Performs data validation.
#>
[NoRunspaceAffinity()]
class Validator {

	<#
	.SYNOPSIS
		The error message describing the validation failure.
	#>
	[ValidateNotNull()]
	[string] $ErrorMessage

	<#
	.SYNOPSIS
		The script block used to perform the validation.
	#>
	[ValidateNotNull()]
	hidden [scriptblock] $Validate

	<#
	.SYNOPSIS
		Creates a new validator.
	.PARAMETER ScriptBlock
		The script block used to perform the validation.
	#>
	Validator([scriptblock] $ScriptBlock) {
		$this.ErrorMessage = ""
		$this.Validate = $ScriptBlock
	}

	<#
	.SYNOPSIS
		Creates a new validator.
	.PARAMETER ErrorMessage
		The error message describing the validation failure.
	.PARAMETER ScriptBlock
		The script block used to perform the validation.
	#>
	Validator([string] $ErrorMessage, [scriptblock] $ScriptBlock) {
		$this.ErrorMessage = $ErrorMessage
		$this.Validate = $ScriptBlock
	}

	<#
	.SYNOPSIS
		Returns a value indicating whether the specified value is valid according to this validator.
	.OUTPUTS
		`$true` if the specified value is valid otherwise `$false`.
	#>
	[bool] IsValid([object] $Value) {
		return & $this.Validate $Value
	}
}
