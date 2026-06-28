using module ../../Validation.psd1

<#
.SYNOPSIS
	Tests the features of the `New-ValidatorNull` cmdlet.
#>
Describe "New-ValidatorNull" {
	Context "IsValid" {
		It "should return `$true if the specified value is `$null"  {
			(New-ValidatorNull "An error occurred.").IsValid($null) | Should -BeTrue
		}

		It "should return `$false if the specified value is not `$null" -ForEach $false, 0, "", @(), @{}, ([pscustomobject]@{}) {
			(New-ValidatorNull "An error occurred.").IsValid($_) | Should -BeFalse
		}
	}
}

<#
.SYNOPSIS
	Tests the features of the `New-ValidatorNotNull` cmdlet.
#>
Describe "New-ValidatorNotNull" {
	Context "IsValid" {
		It "should return `$true if the specified value is not `$null" -ForEach $false, 0, "", @(), @{}, ([pscustomobject]@{}) {
			(New-ValidatorNotNull "An error occurred.").IsValid($_) | Should -BeTrue
		}

		It "should return `$false if the specified value is `$null"  {
			(New-ValidatorNotNull "An error occurred.").IsValid($null) | Should -BeFalse
		}
	}
}
