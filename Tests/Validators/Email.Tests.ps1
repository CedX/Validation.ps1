using module ../../Validation.psd1

<#
.SYNOPSIS
	Tests the features of the `New-ValidatorEmail` cmdlet.
#>
Describe "New-ValidatorEmail" {
	It "should return `$true if the specified value is a well-formed mail address" -ForEach "cedx@outlook.com", "satan@hell.hot" {
		Should-BeTrue (New-ValidatorEmail "Reason").IsValid($_)
	}

	It "should return `$false if the specified value is not a well-formed mail address" -ForEach @(
		"satan@"
		"@hell.hot"
		"satan@hell@hot"
		"satan`r@hell.hot"
	) {
		Should-BeFalse (New-ValidatorEmail "Reason").IsValid($_)
	}
}
