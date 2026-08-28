using namespace System.Diagnostics.CodeAnalysis
using module ../Validation.psd1

<#
.SYNOPSIS
	Tests the features of the `New-Validator` cmdlet.
#>
Describe "New-Validator" {
	Context "ExplicitConversion" {
		It "should create a validator from the specified hash table" {
			$validator = [Belin.Validation.Validator] @{ Reason = "An error occurred."; Test = { $false } }
			Should-BeString "An error occurred." $validator.Reason -CaseSensitive
			Should-HaveType ([scriptblock]) $validator.Test
		}

		It "should throw an exception when the hash table does not provide the expected properties" -ForEach @(
			@{ Reason = "An error occurred." }
			@{ Test = { $false } }
			@{ Reason = 123; Test = { $false } }
			@{ Reason = "An error occurred."; Test = "false" }
		) {
			Should-Throw -ScriptBlock {
				[SuppressMessage("PSUseDeclaredVarsMoreThanAssignments", "validator")]
				$validator = [Belin.Validation.Validator] $_
			}
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
			Should-BeFalse $validator.IsValid($value)
		}

		It "should return `$true if the validated value is valid" -ForEach @(
			@{ Value = $true; Test = { $_ } }
			@{ Value = 123; Test = { $_ -eq 123 } }
			@{ Value = "foo"; Test = { $_ -eq "FOO" } }
			@{ Value = @{ Name = "Cédric" }; Test = { $_.Name -eq "Cédric" } }
		) {
			$validator = New-Validator "Reason" $test
			Should-BeTrue $validator.IsValid($value)
		}
	}

	Context "Reason" {
		It "should be editable from the validation script block" {
			$validator = New-Validator "Reason" {
				$this.Reason = "The error message has been updated."
				return $false
			}

			$validator.IsValid(123)
			Should-BeString "The error message has been updated." $validator.Reason -CaseSensitive
		}
	}
}
