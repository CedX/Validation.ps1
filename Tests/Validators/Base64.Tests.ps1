using module ../../Validation.psd1

<#
.SYNOPSIS
	Tests the features of the `New-ValidatorBase64` cmdlet.
#>
Describe "New-ValidatorBase64" {
	It "should return `$true if the specified value is a well-formed Base64 string" -ForEach @(
		@{ Value = "SGVsbG8gV29ybGQh"; Url = $false }
		@{ Value = "Y2VkeEBvdXRsb29rLmNvbQ=="; Url = $false }
		@{ Value = "Y2VkeEBvdXRsb29rLmNvbQ"; Url = $true }
	) {
		Should-BeTrue (New-ValidatorBase64 "Reason" -Url:$url).IsValid($value)
	}

	It "should return `$false if the specified value is not a well-formed Base64 string" -ForEach @(
		"SGVsbG8gV29ybGQh=="
		"Y2VkeEBvdXRsb29rLmNvbQ"
	) {
		Should-BeFalse (New-ValidatorBase64 "Reason").IsValid($_)
	}
}
