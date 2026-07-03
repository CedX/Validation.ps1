using namespace System.Diagnostics.CodeAnalysis
using module ../Validation.psd1

<#
.SYNOPSIS
	Tests the features of the `New-Validator` cmdlet.
#>
Describe "New-Validator" {
	Context "ImplicitConversion" {
		It "should create a validator from the specified hash table" {
			[Belin.Validation.Validator] $validator = @{ Reason = "An error occurred."; Test = { $false } }
			$validator.Reason | Should -BeExactly "An error occurred."
			$validator.Test | Should -BeOfType ([scriptblock])
		}

		It "should throw an exception when the hash table does not provide the expected properties" -ForEach @(
			@{ Reason = "An error occurred." }
			@{ Test = { $false } }
			@{ Reason = 123; Test = { $false } }
			@{ Reason = "An error occurred."; Test = "false" }
		) {
			$scriptBlock = {
				[SuppressMessage("PSUseDeclaredVarsMoreThanAssignments", "validator")]
				[Belin.Validation.Validator] $validator = $_
			}

			$scriptBlock | Should -Throw
		}
	}

	Context "IsValid" {
		It "should return `$false if the validated value is invalid" -ForEach @(
			@{ Value = $false; Test = { $_ } }
			@{ Value = 123; Test = { $_ -eq 456 } }
			@{ Value = "foo"; Test = { $_ -ceq "FOO" } }
			@{ Value = @{ Name = "Cédric" }; Test = { $_.Name -eq "Belin" } }
		) {
			$validator = New-Validator "Reason" $test
			$validator.IsValid($value) | Should -BeFalse
		}

		It "should return `$true if the validated value is valid" -ForEach @(
			@{ Value = $true; Test = { $_ } }
			@{ Value = 123; Test = { $_ -eq 123 } }
			@{ Value = "foo"; Test = { $_ -eq "FOO" } }
			@{ Value = @{ Name = "Cédric" }; Test = { $_.Name -eq "Cédric" } }
		) {
			$validator = New-Validator "Reason" $test
			$validator.IsValid($value) | Should -BeTrue
		}
	}

	Context "Reason" {
		It "should be editable from the validation script block" {
			$validator = New-Validator "Reason" {
				$this.Reason = "The error message has been updated."
				return $false
			}

			$validator.IsValid(123)
			$validator.Reason | Should -BeExactly "The error message has been updated."
		}
	}
}
