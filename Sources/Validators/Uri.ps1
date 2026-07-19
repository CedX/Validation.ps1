using namespace Belin.Validation

<#
.SYNOPSIS
	Creates a new validator that ensures the validated value is a well-formed absolute URI.
.OUTPUTS
	The newly created validator.
#>
function New-ValidatorUri {
	[CmdletBinding()]
	[OutputType([Belin.Validation.ComparisonValidator])]
	param (
		# The error message describing the validation failure.
		[Parameter(Mandatory, Position = 1)]
		[string] $Reason,

		# The allowed schemes for the URI to validate.
		[Parameter(Position = 2)]
		[ValidateNotNullOrEmpty()]
		[string[]] $Scheme = ("http", "https")
	)

	[ComparisonValidator]@{
		Reason = $Reason
		Test = { ([uri]::IsWellFormedUriString($_, [UriKind]::Absolute)) -and ([uri]::new($_).Scheme -in $this.Value) }
		Value = $Scheme
	}
}
