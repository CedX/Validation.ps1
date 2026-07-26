using namespace System.Diagnostics.CodeAnalysis
using module ../Validation.psd1

<#
.SYNOPSIS
	Tests the features of the `Assert-Validation` cmdlet.
#>
Describe "Assert-Validation" {
	BeforeAll {
		[SuppressMessage("PSUseDeclaredVarsMoreThanAssignments", "hashtable")]
		$hashtable = @{ FirstName = "Cédric"; Gender = "Male" }

		[SuppressMessage("PSUseDeclaredVarsMoreThanAssignments", "object")]
		$object = [pscustomobject] $hashtable
	}

	It "should return an empty hash table if there are no validation errors" {
		foreach ($instance in $hashtable, $object) {
			$errors = Assert-Validation $instance @{ FirstName = New-ValidatorNotEmpty "The first name is required." }
			Should-Be 0 $errors.Count
		}
	}

	It "should return a non-empty hash table if there are validation errors" {
		foreach ($instance in $hashtable, $object) {
			$errors = Assert-Validation $instance @{ LastName = New-ValidatorNotEmpty "The last name is required." }
			Should-Be 1 $errors.Count
			Should-BeString "The last name is required." $errors.LastName -CaseSensitive
		}
	}

	It "should support multiple validators per property" {
		foreach ($instance in $hashtable, $object) {
			$errors = Assert-Validation $instance @{
				FirstName = (New-ValidatorNotEmpty "The first name is required."), (New-ValidatorLike "C*" "The first name must start with the letter C.")
				Gender = (New-ValidatorNotEmpty "The gender is empty."), (New-ValidatorEqual "Female" "Only women are allowed.")
				LastName = New-ValidatorNotEmpty "The last name is required."
				Password = (New-ValidatorNotEmpty "The password is empty."), (New-ValidatorMinLength 5 "The password is too short.")
			}

			Should-Be 3 $errors.Count
			Should-BeString "Only women are allowed." $errors.Gender -CaseSensitive
			Should-BeString "The last name is required." $errors.LastName -CaseSensitive
			Should-BeString "The password is empty." $errors.Password -CaseSensitive
		}
	}
}
