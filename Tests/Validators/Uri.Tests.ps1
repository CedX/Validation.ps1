using module ../../Validation.psd1

<#
.SYNOPSIS
	Tests the features of the `New-ValidatorUri` cmdlet.
#>
Describe "New-ValidatorUri" {
	It "should return `$true if the specified value is a well-formed absolute URI" -ForEach @(
		@{ Value = "https://example.com"; Scheme = "http", "https" }
		@{ Value = "mailto:john.doe@example.com"; Scheme = "mailto" }
		@{ Value = "sftp://ftp.example.com:21"; Scheme = "ftp", "sftp" }
	) {
		Should-BeTrue (New-ValidatorUri "Reason" $scheme).IsValid($value)
	}

	It "should return `$false if the specified value is not a well-formed absolute URI" -ForEach @(
		@{ Value = "example.com"; Scheme = "http", "https" }
		@{ Value = "http://example.com/ folder / file"; Scheme = "http", "https" }
		@{ Value = "mailto:john.doe@example.com"; Scheme = "http", "https" }
	) {
		Should-BeFalse (New-ValidatorUri "Reason" $scheme).IsValid($value)
	}
}
