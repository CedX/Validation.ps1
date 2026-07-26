using namespace System.Diagnostics.CodeAnalysis
using module ../Validation.psd1

<#
.SYNOPSIS
	Tests the features of the `Test-Validation` cmdlet.
#>
Describe "Test-Validation" {
	BeforeAll {
		[SuppressMessage("PSUseDeclaredVarsMoreThanAssignments", "hashtable")]
		$hashtable = @{ FirstName = "Cédric"; Gender = "Male" }

		[SuppressMessage("PSUseDeclaredVarsMoreThanAssignments", "object")]
		$object = [pscustomobject] $hashtable
	}

	It "should return `$true if there are no validation errors" {
		foreach ($instance in $hashtable, $object) {
			Should-BeTrue (Test-Validation $instance @{ FirstName = New-ValidatorNotEmpty "The first name is required." })
		}
	}

	It "should return `$false if there are validation errors" {
		foreach ($instance in $hashtable, $object) {
			Should-BeFalse (Test-Validation $instance @{ LastName = New-ValidatorNotEmpty "The last name is required." })
		}
	}

	It "should support multiple validators per property" {
		foreach ($instance in $hashtable, $object) {
			Should-BeFalse (Test-Validation $instance @{
				FirstName = (New-ValidatorNotEmpty "The first name is required."), (New-ValidatorLike "C*" "The first name must start with the letter C.")
				Gender = (New-ValidatorNotEmpty "The gender is empty."), (New-ValidatorEqual "Female" "Only women are allowed.")
				LastName = New-ValidatorNotEmpty "The last name is required."
				Password = (New-ValidatorNotEmpty "The password is empty."), (New-ValidatorMinLength 5 "The password is too short.")
			})
		}
	}
}
