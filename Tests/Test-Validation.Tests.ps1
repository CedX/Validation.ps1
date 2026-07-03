using namespace System.Diagnostics.CodeAnalysis
using module ../Validation.psd1

<#
.SYNOPSIS
	Tests the features of the `Test-Validation` cmdlet.
#>
Describe "Test-Validation" {
	BeforeAll {
		[SuppressMessage("PSUseDeclaredVarsMoreThanAssignments", "")]
		$hashtable = @{ FirstName = "Cédric"; Gender = "Male" }

		[SuppressMessage("PSUseDeclaredVarsMoreThanAssignments", "")]
		$object = [pscustomobject] $hashtable
	}

	It "should return an empty hash table if there are no validation errors" {
		foreach ($instance in $hashtable, $object) {
			$errors = Test-Validation $instance @{ FirstName = New-ValidatorNotEmpty "The first name is required." }
			$errors.Count | Should -Be 0
		}
	}

	It "should return a non-empty hash table if there are validation errors" -ForEach $hashtable, $object {
		foreach ($instance in $hashtable, $object) {
			$errors = Test-Validation $instance @{ LastName = New-ValidatorNotEmpty "The last name is required." }
			$errors.Count | Should -Be 1
			$errors.LastName | Should -BeExactly "The last name is required."
		}
	}

	It "should support multiple validators per property" -ForEach $hashtable, $object {
		foreach ($instance in $hashtable, $object) {
			$errors = Test-Validation $instance @{
				FirstName = (New-ValidatorNotEmpty "The first name is required."), (New-ValidatorLike "C*" "The first name must start with the letter C.")
				Gender = (New-ValidatorNotEmpty "The gender is empty."), (New-ValidatorEqual "Female" "Only women are allowed.")
				LastName = New-ValidatorNotEmpty "The last name is required."
				Password = (New-ValidatorNotEmpty "The password is empty."), (New-ValidatorMinLength 5 "The password is too short.")
			}

			$errors.Count | Should -Be 3
			$errors.Gender | Should -BeExactly "Only women are allowed."
			$errors.LastName | Should -BeExactly "The last name is required."
			$errors.Password | Should -BeExactly "The password is empty."
		}
	}
}
