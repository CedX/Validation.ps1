using module ../../Validation.psd1

<#
.SYNOPSIS
	Tests the features of the `New-ValidatorIban` cmdlet.
#>
Describe "New-ValidatorIban" {
	It "should return `$true if the specified value is a valid IBAN number" -ForEach @(
		"FR1420041010050500013M02606"
		"GB29NWBK60161331926819"
		"NL91ABNA0417164300"
	) {
		Should-BeTrue (New-ValidatorIban "Reason").IsValid($_)
	}

	It "should return `$false if the specified value is not a valid IBAN number" -ForEach @(
		"NL92ABNA0417164300"
		"NL91ABNA0417164301"
		"GB29NWBK60161331926818"
	) {
		Should-BeFalse (New-ValidatorIban "Reason").IsValid($_)
	}
}
