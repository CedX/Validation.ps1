using module ../../Validation.psd1

<#
.SYNOPSIS
	Tests the features of the `New-ValidatorNotNull` cmdlet.
#>
Describe "New-ValidatorNotNull" {
	It "should return `$false if the specified value is `$null" {
		& (New-ValidatorNotNull) $null | Should -BeFalse
	}

	It "should return `$true if the specified value is not `$null" -ForEach @(0, $false, @(), "", @{}) {
		& (New-ValidatorNotNull) $_ | Should -BeTrue
	}
}
