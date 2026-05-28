<#
.SYNOPSIS
	Represents a validation failure.
#>
[NoRunspaceAffinity()]
class ValidationFailure {

	<#
	.SYNOPSIS
		The property value that caused the failure.
	#>
	[object] $AttemptedValue

	<#
	.SYNOPSIS
		The error message describing the validation failure.
	#>
	[ValidateNotNull()]
	[string] $ErrorMessage

	<#
	.SYNOPSIS
		The name of the validated property.
	#>
	[ValidateNotNullOrWhiteSpace()]
	[string] $PropertyName

	<#
	.SYNOPSIS
		Creates a new validation result.
	.PARAMETER PropertyName
		The name of the validated property.
	#>
	ValidationFailure([string] $PropertyName) {
		$this.AttemptedValue = $null
		$this.ErrorMessage = ""
		$this.PropertyName = $PropertyName
	}

	<#
	.SYNOPSIS
		Creates a new validation result.
	.PARAMETER PropertyName
		The name of the validated property.
	.PARAMETER ErrorMessage
		The error message describing the validation failure.
	#>
	ValidationFailure([string] $PropertyName, [string] $ErrorMessage) {
		$this.AttemptedValue = $null
		$this.ErrorMessage = $ErrorMessage
		$this.PropertyName = $PropertyName
	}

	<#
	.SYNOPSIS
		Creates a new validation result.
	.PARAMETER PropertyName
		The name of the validated property.
	.PARAMETER ErrorMessage
		The error message describing the validation failure.
	.PARAMETER AttemptedValue
		The property value that caused the failure.
	#>
	ValidationFailure([string] $PropertyName, [string] $ErrorMessage, [object] $AttemptedValue) {
		$this.AttemptedValue = $AttemptedValue
		$this.ErrorMessage = $ErrorMessage
		$this.PropertyName = $PropertyName
	}

	<#
	.SYNOPSIS
		Returns a string representation of the failure.
	.OUTPUTS
		The string representation of the failure.
	#>
	[string] ToString() {
		return $this.ErrorMessage
	}
}
