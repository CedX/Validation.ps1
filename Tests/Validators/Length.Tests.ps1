using module ../../Validation.psd1

<#
.SYNOPSIS
	Tests the features of the `New-ValidatorLength` cmdlet.
#>
Describe "New-ValidatorLength" {
	It "should return `$true if the length of the specified string falls between the given bounds" -ForEach @(
		@{ Value = ""; Min = 0; Max = 0 }
		@{ Value = "foo"; Min = 2; Max = 5 }
	) {
		(New-ValidatorLength $min $max "Reason").IsValid($value) | Should-BeTrue
	}

	It "should return `$false if the length of the specified string is outside the given bounds" -ForEach @(
		@{ Value = "bar"; Min = 4; Max = 8 }
		@{ Value = "baz"; Min = 1; Max = 2 }
	) {
		(New-ValidatorLength $min $max "Reason").IsValid($value) | Should-BeFalse
	}

	It "should return `$false if the validated value is not a string" {
		(New-ValidatorLength 0 1000 "Reason").IsValid(123) | Should-BeFalse
	}

	It "should throw an exception if the minimum length is greater than the maximum length" {
		{ New-ValidatorLength 10 5 "Reason" } | Should-Throw
	}
}

<#
.SYNOPSIS
	Tests the features of the `New-ValidatorMaxLength` cmdlet.
#>
Describe "New-ValidatorMaxLength" {
	It "should return `$true if the length of the specified string is less than or equal to the given value" -ForEach @(
		@{ Value = ""; Length = 0 }
		@{ Value = "foo"; Length = 5 }
	) {
		(New-ValidatorMaxLength $length "Reason").IsValid($value) | Should-BeTrue
	}

	It "should return `$false if the length of the specified string is greater than the given value" -ForEach @(
		@{ Value = "bar"; Length = 0 }
		@{ Value = "baz"; Length = 2 }
	) {
		(New-ValidatorMaxLength $length "Reason").IsValid($value) | Should-BeFalse
	}

	It "should return `$false if the validated value is not a string" {
		(New-ValidatorMaxLength 1000 "Reason").IsValid(123) | Should-BeFalse
	}
}

<#
.SYNOPSIS
	Tests the features of the `New-ValidatorMinLength` cmdlet.
#>
Describe "New-ValidatorMinLength" {
	It "should return `$true if the length of the specified string is greater than or equal to the given value" -ForEach @(
		@{ Value = ""; Length = 0 }
		@{ Value = "foo"; Length = 2 }
	) {
		(New-ValidatorMinLength $length "Reason").IsValid($value) | Should-BeTrue
	}

	It "should return `$false if the length of the specified string is less than the given value" -ForEach @(
		@{ Value = ""; Length = 1 }
		@{ Value = "bar"; Length = 5 }
	) {
		(New-ValidatorMinLength $length "Reason").IsValid($value) | Should-BeFalse
	}

	It "should return `$false if the validated value is not a string" {
		(New-ValidatorMinLength 1000 "Reason").IsValid(123) | Should-BeFalse
	}
}
