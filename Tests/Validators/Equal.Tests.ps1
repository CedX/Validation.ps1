using module ../../Validation.psd1

<#
.SYNOPSIS
	Tests the features of the `New-ValidatorEqual` cmdlet.
#>
Describe "New-ValidatorEqual" {
	Context "IsValid" {
		It "should return `$true if the property equals the specified value" -ForEach @(
			@{ Property = $null; Value = $null }
			@{ Property = $true; Value = $true }
			@{ Property = 123; Value = 123 }
			@{ Property = "foo"; Value = "FOO" }
		) {
			(New-ValidatorEqual $value "An error occurred.").IsValid($property) | Should -BeTrue
		}

		It "should return `$false if the property does not equal the specified value" -ForEach @(
			@{ Property = 0; Value = $null }
			@{ Property = $true; Value = $false }
			@{ Property = 123; Value = 456 }
			@{ Property = "foo"; Value = "bar" }
		) {
			(New-ValidatorEqual $value "An error occurred.").IsValid($property) | Should -BeFalse
		}
	}
}

<#
.SYNOPSIS
	Tests the features of the `New-ValidatorNotEqual` cmdlet.
#>
Describe "New-ValidatorNotEqual" {
	Context "IsValid" {
		It "should return `$true if the property does not equal the specified value" -ForEach @(
			@{ Property = 0; Value = $null }
			@{ Property = $true; Value = $false }
			@{ Property = 123; Value = 456 }
			@{ Property = "foo"; Value = "bar" }
		) {
			(New-ValidatorNotEqual $value "An error occurred.").IsValid($property) | Should -BeTrue
		}

		It "should return `$false if the property equals the specified value" -ForEach @(
			@{ Property = $null; Value = $null }
			@{ Property = $true; Value = $true }
			@{ Property = 123; Value = 123 }
			@{ Property = "foo"; Value = "FOO" }
		) {
			(New-ValidatorNotEqual $value "An error occurred.").IsValid($property) | Should -BeFalse
		}
	}
}
