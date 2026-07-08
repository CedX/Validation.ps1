using module ../../Validation.psd1

<#
.SYNOPSIS
	Tests the features of the `New-ValidatorCreditCard` cmdlet.
#>
Describe "New-ValidatorCreditCard" {
	It "should return `$true if the specified value is a well-formed credit card number" -ForEach @(
		"5555444433331111"
		"5376 7473 9720 8720"
		"2223000048400011"
		"2222 4000 4124 0011"
		"4024.0071.5336.1885"
		"340-3161-9380-9364"
		"6011000990139424"
	) {
		(New-ValidatorCreditCard "Reason").IsValid($_) | Should -BeTrue
	}

	It "should return `$false if the specified value is not a well-formed credit card number" -ForEach @(
		""
		"2222"
		"1234 1234 1234 1234"
		"It isn't my credit card number"
	) {
		(New-ValidatorCreditCard "Reason").IsValid($_) | Should -BeFalse
	}
}
