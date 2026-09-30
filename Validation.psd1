@{
	ModuleVersion = "0.7.0"
	PowerShellVersion = "7.6"
	RootModule = "Binaries/Belin.Validation.dll"
	NestedModules = , "Sources/Main.psm1"

	Author = "Cédric Belin <cedx@outlook.com>"
	CompanyName = "Cedric-Belin.fr"
	Copyright = "© Cédric Belin"
	Description = "A simple yet effective validation engine specifically designed for PowerShell."
	GUID = "9c428994-d95d-48c8-af60-8b5db25e22b4"

	AliasesToExport = @()
	VariablesToExport = @()

	CmdletsToExport = @(
		"New-Validator"
		"New-ValidatorBase64"
		"New-ValidatorCount"
		"New-ValidatorCreditCard"
		"New-ValidatorEmail"
		"New-ValidatorEnum"
		"New-ValidatorLike"
		"New-ValidatorMatch"
		"New-ValidatorMaxCount"
		"New-ValidatorMinCount"
		"New-ValidatorNotLike"
		"New-ValidatorNotMatch"
		"New-ValidatorNotNull"
		"New-ValidatorNull"
		"New-ValidatorRange"
		"New-ValidatorUri"
		"New-ValidatorEmpty"
		"New-ValidatorNotEmpty"
		"New-ValidatorEqual"
		"New-ValidatorNotEqual"
	)

	FunctionsToExport = @(
		"Assert-Validation"
		"New-ValidatorGreaterThan"
		"New-ValidatorGreaterThanOrEqual"
		"New-ValidatorIn"
		"New-ValidatorLength"
		"New-ValidatorLessThan"
		"New-ValidatorLessThanOrEqual"
		"New-ValidatorMaxLength"
		"New-ValidatorMinLength"
		"New-ValidatorNotIn"
		"Test-Validation"
	)

	RequiredModules = @(
		@{ ModuleName = "Belin.FSharp"; ModuleVersion = "10.1.401" }
	)

	PrivateData = @{
		PSData = @{
			LicenseUri = "https://github.com/CedX/Validation.ps1/blob/main/License.md"
			ProjectUri = "https://github.com/CedX/Validation.ps1"
			ReleaseNotes = "https://github.com/CedX/Validation.ps1/releases"
			Tags = "data", "dto", "form", "validator", "validation"
		}
	}
}
