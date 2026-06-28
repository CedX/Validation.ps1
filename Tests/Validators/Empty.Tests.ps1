using module ../../Validation.psd1

<#
.SYNOPSIS
	Tests the features of the `New-ValidatorEmpty` cmdlet.
#>
Describe "New-ValidatorEmpty" {
	Context "IsValid" {
		It "should return `$true if the specified value is empty" -ForEach $null, $false, "  ", @(), @{} {
			(New-ValidatorEmpty "An error occurred.").IsValid($_) | Should -BeTrue
		}

		It "should return `$false if the specified value is not empty" -ForEach $true, 1, "foo", @("foo"), @{ Foo = "bar" }, ([pscustomobject]@{}) {
			(New-ValidatorEmpty "An error occurred.").IsValid($_) | Should -BeFalse
		}
	}
}

<#
.SYNOPSIS
	Tests the features of the `New-ValidatorNotEmpty` cmdlet.
#>
Describe "New-ValidatorNotEmpty" {
	Context "IsValid" {
		It "should return `$true if the specified value is not empty" -ForEach $true, 1, "foo", @("foo"), @{ Foo = "bar" }, ([pscustomobject]@{}) {
			(New-ValidatorNotEmpty "An error occurred.").IsValid($_) | Should -BeTrue
		}

		It "should return `$false if the specified value is empty" -ForEach $null, $false, "  ", @(), @{} {
			(New-ValidatorNotEmpty "An error occurred.").IsValid($_) | Should -BeFalse
		}
	}
}
