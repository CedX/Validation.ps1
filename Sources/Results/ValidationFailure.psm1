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
	[string] $ErrorMessage = ""

	<#
	.SYNOPSIS
		The name of the validated property.
	#>
	[ValidateNotNull()]
	[string] $PropertyName = ""

	<#
	.SYNOPSIS
		Returns a string representation of this object.
	.OUTPUTS
		The string representation of this object.
	#>
	[string] ToString() {
		return $this.ErrorMessage
	}
}
