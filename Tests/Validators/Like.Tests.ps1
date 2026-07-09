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
		Should-BeTrue (New-ValidatorLike $pattern "Reason").IsValid($value)
	}

	It "should return `$false if the value does not match the specified pattern" -ForEach @(
		@{ Value = ""; Pattern = "?" }
		@{ Value = "foo"; Pattern = "bar" }
		@{ Value = "baz"; Pattern = "*ar" }
		@{ Value = "qux"; Pattern = "qi*" }
	) {
		Should-BeFalse (New-ValidatorLike $pattern "Reason").IsValid($value)
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
		Should-BeTrue (New-ValidatorNotLike $pattern "Reason").IsValid($value)
	}

	It "should return `$false if the value matches the specified pattern" -ForEach @(
		@{ Value = ""; Pattern = "*" }
		@{ Value = "foo"; Pattern = "FOO" }
		@{ Value = "bar"; Pattern = "ba*" }
		@{ Value = "baz"; Pattern = "*z" }
	) {
		Should-BeFalse (New-ValidatorNotLike $pattern "Reason").IsValid($value)
	}
}
