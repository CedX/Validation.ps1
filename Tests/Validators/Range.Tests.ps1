using module ../../Validation.psd1

<#
.SYNOPSIS
	Tests the features of the `New-ValidatorRange` cmdlet.
#>
Describe "New-ValidatorRange" {
	Context "Error" {
		It "should throw an exception if the minimum value is greater than the maximum value" {
			{ New-ValidatorRange 10 5 "Reason" } | Should -Throw
		}
	}

	Context "Exclusive" {
		It "should return `$true if the specified value falls between the given bounds" -ForEach @(
			@{ Value = 0.0; From = -1; To = 1 }
			@{ Value = 456; From = 123; To = 666 }
			@{ Value = 100.99; From = 100; To = 101 }
		) {
			(New-ValidatorRange $from $to "Reason" -Exclusive).IsValid($value) | Should -BeTrue
		}

		It "should return `$false if the specified value is outside the given bounds" -ForEach @(
			@{ Value = 0; From = 0; To = 0 }
			@{ Value = 0; From = 1; To = 2 }
			@{ Value = -456; From = -123; To = 0 }
		) {
			(New-ValidatorRange $from $to "Reason" -Exclusive).IsValid($value) | Should -BeFalse
		}
	}

	Context "Inclusive" {
		It "should return `$true if the specified value falls between the given bounds" -ForEach @(
			@{ Value = 0; From = 0; To = 0 }
			@{ Value = 0.0; From = -1; To = 1 }
			@{ Value = 456; From = 123; To = 666 }
			@{ Value = 100.99; From = 100; To = 101 }
		) {
			(New-ValidatorRange $from $to "Reason").IsValid($value) | Should -BeTrue
		}

		It "should return `$false if the specified value is outside the given bounds" -ForEach @(
			@{ Value = 0; From = 1; To = 2 }
			@{ Value = -456; From = -123; To = 0 }
		) {
			(New-ValidatorRange $from $to "Reason").IsValid($value) | Should -BeFalse
		}
	}
}
