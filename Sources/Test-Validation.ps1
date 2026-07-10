using namespace Belin.Validation

<#
.SYNOPSIS
	Performs the data validation on the specified object according to a given set of validation rules.
.INPUTS
	The object to validate.
.OUTPUTS
	The validation errors, if any.
#>
function Test-Validation {
	[CmdletBinding()]
	[OutputType([hashtable])]
	param (
		# The object to validate.
		[Parameter(Mandatory, Position = 1, ValueFromPipeline)]
		[object] $Object,

		# The set of validation rules to apply.
		[Parameter(Mandatory, Position = 2)]
		[hashtable] $RuleSet
	)

	process {
		$errors = @{}

		foreach ($property in $RuleSet.Keys) {
			foreach ($item in @($RuleSet[$property])) {
				$validator = [Validator] $item
				if (-not $validator.IsValid($Object.$property)) {
					$errors[$property] = $validator.Reason
					break
				}
			}
		}

		$errors
	}
}
