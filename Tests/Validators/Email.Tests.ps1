using module ../../Validation.psd1

<#
.SYNOPSIS
	Tests the features of the `New-ValidatorEmail` cmdlet.
#>
Describe "New-ValidatorEmail" {
	It "should return `$true if the specified value is a well-formed mail address" -ForEach "cedx@outlook.com", "satan@hell.hot" {
		(New-ValidatorEmail "Reason").IsValid($_) | Should-BeTrue
	}

	It "should return `$false if the specified value is not a well-formed mail address" -ForEach @(
		"satan@"
		"@hell.hot"
		"satan@hell@hot"
		"satan`r@hell.hot"
	) {
		(New-ValidatorEmail "Reason").IsValid($_) | Should-BeFalse
	}
}
