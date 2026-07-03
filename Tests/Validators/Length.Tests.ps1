using module ../../Validation.psd1

<#
.SYNOPSIS
	Tests the features of the `New-ValidatorLength` cmdlet.
#>
Describe "New-ValidatorLength" {
	Context "IsValid" {
		It "should return `$true if the length of the specified string falls between the given bounds" -ForEach @(
			@{ Value = ""; MinLength = 0; MaxLength = 0 }
			@{ Value = "foo"; MinLength = 2; MaxLength = 5 }
		) {
			(New-ValidatorLength $minLength $maxLength "An error occurred.").IsValid($value) | Should -BeTrue
		}

		It "should return `$false if the length of the specified string is outside the given bounds" -ForEach @(
			@{ Value = "bar"; MinLength = 4; MaxLength = 8 }
			@{ Value = "baz"; MinLength = 1; MaxLength = 2 }
		) {
			(New-ValidatorLength $minLength $maxLength "An error occurred.").IsValid($value) | Should -BeFalse
		}

		It "should throw an exception if the minimum length is greater than the maximum length" {
			{ New-ValidatorLength 10 5 "An error occurred." } | Should -Throw
		}
	}
}

<#
.SYNOPSIS
	Tests the features of the `New-ValidatorMaxLength` cmdlet.
#>
Describe "New-ValidatorMaxLength" {
	Context "IsValid" {
		It "should return `$true if the length of the specified string is less than or equal to the given value" -ForEach @(
			@{ Value = ""; Length = 0 }
			@{ Value = "foo"; Length = 5 }
		) {
			(New-ValidatorMaxLength $length "An error occurred.").IsValid($value) | Should -BeTrue
		}

		It "should return `$false if the length of the specified string is greater than the given value" -ForEach @(
			@{ Value = "bar"; Length = 0 }
			@{ Value = "baz"; Length = 2 }
		) {
			(New-ValidatorMaxLength $length "An error occurred.").IsValid($value) | Should -BeFalse
		}
	}
}

<#
.SYNOPSIS
	Tests the features of the `New-ValidatorMinLength` cmdlet.
#>
Describe "New-ValidatorMinLength" {
	Context "IsValid" {
		It "should return `$true if the length of the specified string is greater than or equal to the given value" -ForEach @(
			@{ Value = ""; Length = 0 }
			@{ Value = "foo"; Length = 2 }
		) {
			(New-ValidatorMinLength $length "An error occurred.").IsValid($value) | Should -BeTrue
		}

		It "should return `$false if the length of the specified string is less than the given value" -ForEach @(
			@{ Value = ""; Length = 1 }
			@{ Value = "bar"; Length = 5 }
		) {
			(New-ValidatorMinLength $length "An error occurred.").IsValid($value) | Should -BeFalse
		}
	}
}
