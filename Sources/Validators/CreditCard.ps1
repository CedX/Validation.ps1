using namespace Belin.Validation

<#
.SYNOPSIS
	Creates a new validator that ensures the validated value is a well-formed credit card number.
.OUTPUTS
	The newly created validator.
#>
function New-ValidatorCreditCard {
	[CmdletBinding()]
	[OutputType([Belin.Validation.Validator])]
	param (
		# The error message describing the validation failure.
		[Parameter(Mandatory, Position = 1)]
		[string] $Reason
	)

	New-Validator $Reason {
		$number = $_ -replace "[-. ]"
		if ($number -notmatch "^\d{8,19}$") { return $false }

		$characters = $number.ToCharArray()
		[array]::Reverse($characters)

		$checksum = 0
		$evenDigit = $false

		foreach ($character in $characters) {
			$digit = ($character - [char] "0") * ($evenDigit ? 2 : 1)
			$evenDigit = -not $evenDigit

			while ($digit -gt 0) {
				$checksum += $digit % 10
				$digit = [int] [Math]::Truncate($digit / 10)
			}
		}

		($checksum % 10) -eq 0
	}
}
