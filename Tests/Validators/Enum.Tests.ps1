using module ../../Validation.psd1

<#
.SYNOPSIS
	Tests the features of the `New-ValidatorEnum` cmdlet.
#>
Describe "New-ValidatorEnum" {
	It "should return `$true if the specified value is defined" -ForEach @(
		0, "Sunday"
		6, "Saturday"
	) {
		Should-BeTrue (New-ValidatorEnum ([DayOfWeek]) "Reason").IsValid($_)
	}

	It "should return `$false if the specified value is not defined" -ForEach @(
		7, "Septidi"
		9, "Nonidi"
	) {
		Should-BeFalse (New-ValidatorEnum ([DayOfWeek]) "Reason").IsValid($_)
	}
}
