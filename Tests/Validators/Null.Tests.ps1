using module ../../Validation.psd1

<#
.SYNOPSIS
	Tests the features of the `New-ValidatorNull` cmdlet.
#>
Describe "New-ValidatorNull" {
	It "should return `$true if the specified value is `$null" {
		Should-BeTrue (New-ValidatorNull "Reason").IsValid($null)
	}

	It "should return `$false if the specified value is not `$null" -ForEach $false, 0, "", @(), @{}, ([pscustomobject]@{}) {
		Should-BeFalse (New-ValidatorNull "Reason").IsValid($_)
	}
}

<#
.SYNOPSIS
	Tests the features of the `New-ValidatorNotNull` cmdlet.
#>
Describe "New-ValidatorNotNull" {
	It "should return `$true if the specified value is not `$null" -ForEach $false, 0, "", @(), @{}, ([pscustomobject]@{}) {
		Should-BeTrue (New-ValidatorNotNull "Reason").IsValid($_)
	}

	It "should return `$false if the specified value is `$null" {
		Should-BeFalse (New-ValidatorNotNull "Reason").IsValid($null)
	}
}
