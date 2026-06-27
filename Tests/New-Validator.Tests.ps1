using module ../Validation.psd1

<#
.SYNOPSIS
	Tests the features of the `New-Validator` cmdlet.
#>
Describe "New-Validator" {
	Context "ImplicitConversion" {
		It "should create a validator from the specified hash table" {
			[Belin.Validation.Validator] $validator = @{ Reason = "An error occurred."; Test = {} }
			$validator.Reason | Should -BeExactly "An error occurred."
			$validator.Test | Should -BeOfType ([scriptblock])
		}
	}
}
