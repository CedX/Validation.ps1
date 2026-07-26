using namespace Belin.Validation

<#
.SYNOPSIS
	Performs the data validation on the specified object according to a given set of validation rules.
.INPUTS
	The object to validate.
.OUTPUTS
	`$true` if the validated object is valid, otherwise `$false`.
#>
function Test-Validation {
	[CmdletBinding()]
	[OutputType([bool])]
	param (
		# The object to validate.
		[Parameter(Mandatory, Position = 1, ValueFromPipeline)]
		[object] $Object,

		# The set of validation rules to apply.
		[Parameter(Mandatory, Position = 2)]
		[hashtable] $RuleSet
	)

	process {
		foreach ($property in $RuleSet.Keys) {
			foreach ($rule in @($RuleSet[$property])) {
				$validator = [Validator] $rule
				if (-not $validator.IsValid($Object.$property)) { return $false }
			}
		}

		$true
	}
}
