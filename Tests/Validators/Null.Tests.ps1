using module ../../Validation.psd1

<#
.SYNOPSIS
	Tests the features of the `New-ValidatorNull` cmdlet.
#>
Describe "New-ValidatorNull" {
	It "should return `$true if the specified value is `$null" {
		(New-ValidatorNull "Reason").IsValid($null) | Should-BeTrue
	}

	It "should return `$false if the specified value is not `$null" -ForEach $false, 0, "", @(), @{}, ([pscustomobject]@{}) {
		(New-ValidatorNull "Reason").IsValid($_) | Should-BeFalse
	}
}

<#
.SYNOPSIS
	Tests the features of the `New-ValidatorNotNull` cmdlet.
#>
Describe "New-ValidatorNotNull" {
	It "should return `$true if the specified value is not `$null" -ForEach $false, 0, "", @(), @{}, ([pscustomobject]@{}) {
		(New-ValidatorNotNull "Reason").IsValid($_) | Should-BeTrue
	}

	It "should return `$false if the specified value is `$null" {
		(New-ValidatorNotNull "Reason").IsValid($null) | Should-BeFalse
	}
}
