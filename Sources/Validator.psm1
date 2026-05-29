<#
.SYNOPSIS
	Performs data validation.
#>
class Validator {

	<#
	.SYNOPSIS
		The error message describing the validation failure.
	#>
	[ValidateNotNull()]
	[string] $ErrorMessage

	<#
	.SYNOPSIS
		Additional parameters to pass to the validation script block.
	#>
	hidden [object[]] $Parameters

	<#
	.SYNOPSIS
		The script block used to perform the validation.
	#>
	[ValidateNotNull()]
	hidden [scriptblock] $Validate  # TODO empêche NoRunspaceAffinity

	<#
	.SYNOPSIS
		Creates a new validator.
	.PARAMETER ScriptBlock
		The script block used to perform the validation.
	#>
	Validator([scriptblock] $ScriptBlock) {
		$this.ErrorMessage = ""
		$this.Parameters = @()
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
		$this.Parameters = @()
		$this.Validate = $ScriptBlock
	}

	<#
	.SYNOPSIS
		Creates a new validator.
	.PARAMETER ErrorMessage
		The error message describing the validation failure.
	.PARAMETER Parameters
		Additional parameters to pass to the validation script block.
	.PARAMETER ScriptBlock
		The script block used to perform the validation.
	#>
	Validator([string] $ErrorMessage, [object[]] $Parameters, [scriptblock] $ScriptBlock) {
		$this.ErrorMessage = $ErrorMessage
		$this.Parameters = $Parameters
		$this.Validate = $ScriptBlock
	}

	<#
	.SYNOPSIS
		Returns a value indicating whether the specified value is valid according to this validator.
	.OUTPUTS
		`$true` if the specified value is valid otherwise `$false`.
	#>
	[bool] IsValid([object] $Value) {
		$arguments = $this.Parameters
		return & $this.Validate $Value @arguments
	}
}
