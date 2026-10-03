using module ../../Validation.psd1

<#
.SYNOPSIS
	Tests the features of the `New-ValidatorEmpty` cmdlet.
#>
Describe "New-ValidatorEmpty" {
	It "should return `$true if the specified value is empty" -ForEach $null, $false, "  ", @(), @{} {
		(New-ValidatorEmpty "Reason").IsValid($_) | Should-BeTrue
	}

	It "should return `$false if the specified value is not empty" -ForEach $true, 1, "foo", @("foo"), @{ Foo = "bar" }, ([pscustomobject]@{}) {
		(New-ValidatorEmpty "Reason").IsValid($_) | Should-BeFalse
	}
}

<#
.SYNOPSIS
	Tests the features of the `New-ValidatorNotEmpty` cmdlet.
#>
Describe "New-ValidatorNotEmpty" {
	It "should return `$true if the specified value is not empty" -ForEach $true, 1, "foo", @("foo"), @{ Foo = "bar" }, ([pscustomobject]@{}) {
		(New-ValidatorNotEmpty "Reason").IsValid($_) | Should-BeTrue
	}

	It "should return `$false if the specified value is empty" -ForEach $null, $false, "  ", @(), @{} {
		(New-ValidatorNotEmpty "Reason").IsValid($_) | Should-BeFalse
	}
}
