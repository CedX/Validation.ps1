using module ../../Validation.psd1

<#
.SYNOPSIS
	Tests the features of the `New-ValidatorIn` cmdlet.
#>
Describe "New-ValidatorIn" {
	It "should return `$true if the property matches an element from a set of values" -ForEach @(
		@{ Property = "FOO"; Values = "foo", "bar", "baz" }
		@{ Property = 123; Values = 123, 456, 789 }
	) {
		(New-ValidatorIn $values "Reason").IsValid($property) | Should-BeTrue
	}

	It "should return `$false if the property does not match an element from a set of values" -ForEach @(
		@{ Property = "ABC"; Values = "AB", "CD", "EF" }
		@{ Property = 666; Values = 123, 456, 789 }
	) {
		(New-ValidatorIn $values "Reason").IsValid($property) | Should-BeFalse
	}
}

<#
.SYNOPSIS
	Tests the features of the `New-ValidatorNotIn` cmdlet.
#>
Describe "New-ValidatorNotIn" {
	It "should return `$true if the property does not match an element from a set of values" -ForEach @(
		@{ Property = "ABC"; Values = "AB", "CD", "EF" }
		@{ Property = 666; Values = 123, 456, 789 }
	) {
		(New-ValidatorNotIn $values "Reason").IsValid($property) | Should-BeTrue
	}

	It "should return `$false if the property matches an element from a set of values" -ForEach @(
		@{ Property = "FOO"; Values = "foo", "bar", "baz" }
		@{ Property = 123; Values = 123, 456, 789 }
	) {
		(New-ValidatorNotIn $values "Reason").IsValid($property) | Should-BeFalse
	}
}
