using module ../../Validation.psd1

<#
.SYNOPSIS
	Tests the features of the `New-ValidatorNull` cmdlet.
#>
Describe "New-ValidatorNull" {
	It "should return `$true if the specified value is `$null" -ForEach $null {
		& (New-ValidatorNull) $_ | Should -BeTrue
	}

	It "should return `$false if the specified value is not `$null" -ForEach $false, 0, "", @(), @{}, ([pscustomobject]@{}) {
		& (New-ValidatorNull) $_ | Should -BeFalse
	}
}

<#
.SYNOPSIS
	Tests the features of the `New-ValidatorNotNull` cmdlet.
#>
Describe "New-ValidatorNotNull" {
	It "should return `$true if the specified value is not `$null" -ForEach $false, 0, "", @(), @{}, ([pscustomobject]@{}) {
		& (New-ValidatorNotNull) $_ | Should -BeTrue
	}

	It "should return `$false if the specified value is `$null" -ForEach $null {
		& (New-ValidatorNotNull) $_ | Should -BeFalse
	}
}
