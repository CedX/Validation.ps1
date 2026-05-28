using module ../../Validation.psd1

<#
.SYNOPSIS
	Tests the features of the `New-ValidatorNotNull` cmdlet.
#>
Describe "New-ValidatorNotNull" {
	It "should return `$true if the specified value is not `$null" -ForEach $false, 0, @(), "", @{} {
		& (New-ValidatorNotNull) $_ | Should -BeTrue
	}

	It "should return `$false if the specified value is `$null" -ForEach $null {
		& (New-ValidatorNotNull) $_ | Should -BeFalse
	}
}
