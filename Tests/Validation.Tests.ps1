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
		$psObject = [pscustomobject] $hashtable
	}

	It "should return an empty hash table if there are no validation errors" {
		$rules = @{ FirstName = New-ValidatorNotEmpty "The first name is required." }
		$hashtable, $psObject | ForEach-Object {
			$errors = Assert-Validation $_ $rules
			$errors.Count | Should-Be 0
		}
	}

	It "should return a non-empty hash table if there are validation errors" {
		$rules = @{ LastName = New-ValidatorNotEmpty "The last name is required." }
		$hashtable, $psObject | ForEach-Object {
			$errors = $_ | Assert-Validation -RuleSet $rules
			$errors.Count | Should-Be 1
			$errors.LastName | Should-BeString "The last name is required." -CaseSensitive
		}
	}

	It "should support multiple validators per property" {
		$rules = @{
			FirstName = (New-ValidatorNotEmpty "The first name is required."), (New-ValidatorLike "C*" "The first name must start with the letter C.")
			Gender = (New-ValidatorNotEmpty "The gender is empty."), (New-ValidatorEqual "Female" "Only women are allowed.")
			LastName = New-ValidatorNotEmpty "The last name is required."
			Password = (New-ValidatorNotEmpty "The password is empty."), (New-ValidatorMinLength 5 "The password is too short.")
		}

		$hashtable, $psObject | ForEach-Object {
			$errors = $_ | Assert-Validation -RuleSet $rules
			$errors.Count | Should-Be 3
			$errors.Gender | Should-BeString "Only women are allowed." -CaseSensitive
			$errors.LastName | Should-BeString "The last name is required." -CaseSensitive
			$errors.Password | Should-BeString "The password is empty." -CaseSensitive
		}
	}
}

<#
.SYNOPSIS
	Tests the features of the `Test-Validation` cmdlet.
#>
Describe "Test-Validation" {
	BeforeAll {
		[SuppressMessage("PSUseDeclaredVarsMoreThanAssignments", "hashtable")]
		$hashtable = @{ FirstName = "Cédric"; Gender = "Male" }

		[SuppressMessage("PSUseDeclaredVarsMoreThanAssignments", "object")]
		$psObject = [pscustomobject] $hashtable
	}

	It "should return `$true if there are no validation errors" {
		$rules = @{ FirstName = New-ValidatorNotEmpty "The first name is required." }
		$hashtable, $psObject | ForEach-Object {
			(Test-Validation $_ $rules) | Should-BeTrue
			($_ | Test-Validation -RuleSet $rules) | Should-BeTrue
		}
	}

	It "should return `$false if there are validation errors" {
		$rules = @{ LastName = New-ValidatorNotEmpty "The last name is required." }
		$hashtable, $psObject | ForEach-Object {
			(Test-Validation $_ $rules) | Should-BeFalse
			($_ | Test-Validation -RuleSet $rules) | Should-BeFalse
		}
	}

	It "should support multiple validators per property" {
		$rules = @{
			FirstName = (New-ValidatorNotEmpty "The first name is required."), (New-ValidatorLike "C*" "The first name must start with the letter C.")
			Gender = (New-ValidatorNotEmpty "The gender is empty."), (New-ValidatorEqual "Female" "Only women are allowed.")
			LastName = New-ValidatorNotEmpty "The last name is required."
			Password = (New-ValidatorNotEmpty "The password is empty."), (New-ValidatorMinLength 5 "The password is too short.")
		}

		$hashtable, $psObject | ForEach-Object {
			(Test-Validation $_ $rules) | Should-BeFalse
			($_ | Test-Validation -RuleSet $rules) | Should-BeFalse
		}
	}
}
