using module ../../Validation.psd1

<#
.SYNOPSIS
	Tests the features of the `New-ValidatorCount` cmdlet.
#>
Describe "New-ValidatorCount" {
	It "should return `$true if the length of the specified collection falls between the given bounds" -ForEach @(
		@{ Value = $null; Min = 0; Max = 0 }
		@{ Value = @(); Min = 0; Max = 0 }
		@{ Value = "foo", "bar", "baz"; Min = 2; Max = 5 }
	) {
		Should-BeTrue (New-ValidatorCount $min $max "Reason").IsValid($value)
	}

	It "should return `$false if the length of the specified collection is outside the given bounds" -ForEach @(
		@{ Value = "foo", "bar", "baz"; Min = 4; Max = 8 }
		@{ Value = "foo", "bar", "baz"; Min = 1; Max = 2 }
	) {
		Should-BeFalse (New-ValidatorCount $min $max "Reason").IsValid($value)
	}

	It "should throw an exception if the minimum length is greater than the maximum length" {
		Should-Throw -ScriptBlock { New-ValidatorCount 10 5 "Reason" }
	}
}

<#
.SYNOPSIS
	Tests the features of the `New-ValidatorMaxCount` cmdlet.
#>
Describe "New-ValidatorMaxCount" {
	It "should return `$true if the length of the specified collection is less than or equal to the given value" -ForEach @(
		@{ Value = $null; Count = 0 }
		@{ Value = @(); Count = 0 }
		@{ Value = "foo", "bar", "baz"; Count = 5 }
	) {
		Should-BeTrue (New-ValidatorMaxCount $count "Reason").IsValid($value)
	}

	It "should return `$false if the length of the specified collection is greater than the given value" -ForEach @(
		@{ Value = 123, 456; Count = 0 }
		@{ Value = "foo", "bar", "baz"; Count = 2 }
	) {
		Should-BeFalse (New-ValidatorMaxCount $count "Reason").IsValid($value)
	}
}

<#
.SYNOPSIS
	Tests the features of the `New-ValidatorMinCount` cmdlet.
#>
Describe "New-ValidatorMinCount" {
	It "should return `$true if the length of the specified collection is greater than or equal to the given value" -ForEach @(
		@{ Value = @(); Count = 0 }
		@{ Value = "foo", "bar", "baz"; Count = 2 }
	) {
		Should-BeTrue (New-ValidatorMinCount $count "Reason").IsValid($value)
	}

	It "should return `$false if the length of the specified collection is less than the given value" -ForEach @(
		@{ Value = $null; Count = 1 }
		@{ Value = @(); Count = 1 }
		@{ Value = , "bar"; Count = 5 }
	) {
		Should-BeFalse (New-ValidatorMinCount $count "Reason").IsValid($value)
	}
}
