using module ../../Validation.psd1

<#
.SYNOPSIS
	Tests the features of the `New-ValidatorLessThan` cmdlet.
#>
Describe "New-ValidatorLessThan" {
	It "should return `$true if the property is less than the specified value" -ForEach @(
		@{ Property = $false; Value = $true }
		@{ Property = 123; Value = 456 }
		@{ Property = 0; Value = 1.5 }
		@{ Property = "A"; Value = "B" }
	) {
		(New-ValidatorLessThan $value "Reason").IsValid($property) | Should-BeTrue
	}

	It "should return `$false if the property is greater than or equal to the specified value" -ForEach @(
		@{ Property = $null; Value = $null }
		@{ Property = 1; Value = $null }
		@{ Property = $true; Value = $false }
		@{ Property = 456; Value = 123 }
		@{ Property = 1.5; Value = 0 }
		@{ Property = "a"; Value = "a" }
		@{ Property = "B"; Value = "A" }
	) {
		(New-ValidatorLessThan $value "Reason").IsValid($property) | Should-BeFalse
	}
}

<#
.SYNOPSIS
	Tests the features of the `New-ValidatorLessThanOrEqual` cmdlet.
#>
Describe "New-ValidatorLessThanOrEqual" {
	It "should return `$true if the property is less than or equal the specified value" -ForEach @(
		@{ Property = $null; Value = $null }
		@{ Property = $false; Value = $true }
		@{ Property = 123; Value = 456 }
		@{ Property = 0; Value = 1.5 }
		@{ Property = "a"; Value = "a" }
		@{ Property = "A"; Value = "B" }
	) {
		(New-ValidatorLessThanOrEqual $value "Reason").IsValid($property) | Should-BeTrue
	}

	It "should return `$false if the property is greater than the specified value" -ForEach @(
		@{ Property = 1; Value = $null }
		@{ Property = $true; Value = $false }
		@{ Property = 456; Value = 123 }
		@{ Property = 1.5; Value = 0 }
		@{ Property = "B"; Value = "A" }
	) {
		(New-ValidatorLessThanOrEqual $value "Reason").IsValid($property) | Should-BeFalse
	}
}
