using module ../../Validation.psd1

<#
.SYNOPSIS
	Tests the features of the `New-ValidatorEmpty` cmdlet.
#>
Describe "New-ValidatorEmpty" {
	It "should return `$true if the specified value is empty" -ForEach $null, $false, "  ", @(), @{} {
		Should-BeTrue (New-ValidatorEmpty "Reason").IsValid($_)
	}

	It "should return `$false if the specified value is not empty" -ForEach $true, 1, "foo", @("foo"), @{ Foo = "bar" }, ([pscustomobject]@{}) {
		Should-BeFalse (New-ValidatorEmpty "Reason").IsValid($_)
	}
}

<#
.SYNOPSIS
	Tests the features of the `New-ValidatorNotEmpty` cmdlet.
#>
Describe "New-ValidatorNotEmpty" {
	It "should return `$true if the specified value is not empty" -ForEach $true, 1, "foo", @("foo"), @{ Foo = "bar" }, ([pscustomobject]@{}) {
		Should-BeTrue (New-ValidatorNotEmpty "Reason").IsValid($_)
	}

	It "should return `$false if the specified value is empty" -ForEach $null, $false, "  ", @(), @{} {
		Should-BeFalse (New-ValidatorNotEmpty "Reason").IsValid($_)
	}
}
