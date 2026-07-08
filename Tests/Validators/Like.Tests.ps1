using module ../../Validation.psd1

<#
.SYNOPSIS
	Tests the features of the `New-ValidatorLike` cmdlet.
#>
Describe "New-ValidatorLike" {
	It "should return `$true if the value matches the specified pattern" -ForEach @(
		@{ Value = ""; Pattern = "*" }
		@{ Value = "foo"; Pattern = "FOO" }
		@{ Value = "bar"; Pattern = "ba*" }
		@{ Value = "baz"; Pattern = "*z" }
	) {
		(New-ValidatorLike $pattern "Reason").IsValid($value) | Should-BeTrue
	}

	It "should return `$false if the value does not match the specified pattern" -ForEach @(
		@{ Value = ""; Pattern = "?" }
		@{ Value = "foo"; Pattern = "bar" }
		@{ Value = "baz"; Pattern = "*ar" }
		@{ Value = "qux"; Pattern = "qi*" }
	) {
		(New-ValidatorLike $pattern "Reason").IsValid($value) | Should-BeFalse
	}
}

<#
.SYNOPSIS
	Tests the features of the `New-ValidatorNotLike` cmdlet.
#>
Describe "New-ValidatorNotLike" {
	It "should return `$true if the value does not match the specified pattern" -ForEach @(
		@{ Value = ""; Pattern = "?" }
		@{ Value = "foo"; Pattern = "bar" }
		@{ Value = "baz"; Pattern = "*ar" }
		@{ Value = "qux"; Pattern = "qi*" }
	) {
		(New-ValidatorNotLike $pattern "Reason").IsValid($value) | Should-BeTrue
	}

	It "should return `$false if the value matches the specified pattern" -ForEach @(
		@{ Value = ""; Pattern = "*" }
		@{ Value = "foo"; Pattern = "FOO" }
		@{ Value = "bar"; Pattern = "ba*" }
		@{ Value = "baz"; Pattern = "*z" }
	) {
		(New-ValidatorNotLike $pattern "Reason").IsValid($value) | Should-BeFalse
	}
}
