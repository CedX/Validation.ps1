@{
	ModuleVersion = "0.2.0"
	PowerShellVersion = "7.6"
	RootModule = "Sources/Main.psm1"

	Author = "Cédric Belin <cedx@outlook.com>"
	CompanyName = "Cedric-Belin.fr"
	Copyright = "© Cédric Belin"
	Description = "A simple yet effective validation engine specifically designed for PowerShell."
	GUID = "9c428994-d95d-48c8-af60-8b5db25e22b4"

	AliasesToExport = @()
	CmdletsToExport = @()
	RequiredAssemblies = , "Binaries/Belin.Validation.dll"
	VariablesToExport = @()

	FunctionsToExport = @(
		"New-Validator"
		"New-ValidatorCreditCard"
		"New-ValidatorEmpty"
		"New-ValidatorEqual"
		"New-ValidatorGreaterThan"
		"New-ValidatorGreaterThanOrEqual"
		"New-ValidatorIn"
		"New-ValidatorLength"
		"New-ValidatorLessThan"
		"New-ValidatorLessThanOrEqual"
		"New-ValidatorLike"
		"New-ValidatorMatch"
		"New-ValidatorMaxLength"
		"New-ValidatorMinLength"
		"New-ValidatorNotEmpty"
		"New-ValidatorNotEqual"
		"New-ValidatorNotIn"
		"New-ValidatorNotLike"
		"New-ValidatorNotMatch"
		"New-ValidatorNotNull"
		"New-ValidatorNull"
		"New-ValidatorRange"
		"Test-Validation"
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
