using module ../../Validation.psd1

<#
.SYNOPSIS
	Tests the features of the `New-ValidatorMatch` cmdlet.
#>
Describe "New-ValidatorMatch" {
	It "should return `$true if the value matches the specified pattern" -ForEach @(
		@{ Value = ""; Pattern = ".*" }
		@{ Value = "foo"; Pattern = "^FOO$" }
		@{ Value = "bar"; Pattern = "^bar?" }
		@{ Value = "baz"; Pattern = ".z$" }
	) {
		(New-ValidatorMatch $pattern "Reason").IsValid($value) | Should-BeTrue
	}

	It "should return `$false if the value does not match the specified pattern" -ForEach @(
		@{ Value = ""; Pattern = "." }
		@{ Value = "foo"; Pattern = "bar" }
		@{ Value = "baz"; Pattern = "ar$" }
		@{ Value = "qux"; Pattern = "^qi" }
	) {
		(New-ValidatorMatch $pattern "Reason").IsValid($value) | Should-BeFalse
	}
}

<#
.SYNOPSIS
	Tests the features of the `New-ValidatorNotMatch` cmdlet.
#>
Describe "New-ValidatorNotMatch" {
	It "should return `$true if the value does not match the specified pattern" -ForEach @(
		@{ Value = ""; Pattern = "." }
		@{ Value = "foo"; Pattern = "bar" }
		@{ Value = "baz"; Pattern = "ar$" }
		@{ Value = "qux"; Pattern = "^qi" }
	) {
		(New-ValidatorNotMatch $pattern "Reason").IsValid($value) | Should-BeTrue
	}

	It "should return `$false if the value matches the specified pattern" -ForEach @(
		@{ Value = ""; Pattern = ".*" }
		@{ Value = "foo"; Pattern = "^FOO$" }
		@{ Value = "bar"; Pattern = "^bar?" }
		@{ Value = "baz"; Pattern = ".z$" }
	) {
		(New-ValidatorNotMatch $pattern "Reason").IsValid($value) | Should-BeFalse
	}
}
