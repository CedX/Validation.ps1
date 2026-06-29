@{
	# TODO ? DefaultCommandPrefix = "Validigo"
	ModuleVersion = "0.1.0"
	PowerShellVersion = "7.6"
	RootModule = "Sources/Main.psm1"

	Author = "Cédric Belin <cedx@outlook.com>"
	CompanyName = "Cedric-Belin.fr"
	Copyright = "© Cédric Belin"
	Description = "TODO"
	GUID = "9c428994-d95d-48c8-af60-8b5db25e22b4"

	AliasesToExport = @()
	CmdletsToExport = @()
	RequiredAssemblies = , "Binaries/Belin.Validation.dll"
	VariablesToExport = @()

	FunctionsToExport = @(
		"New-Validator"
		"New-ValidatorEmpty"
		# "New-ValidatorGreaterThan"
		# "New-ValidatorGreaterThanOrEqual"
		"New-ValidatorNotEmpty"
		"New-ValidatorNotNull"
		"New-ValidatorNull"
	)

	PrivateData = @{
		PSData = @{
			LicenseUri = "https://github.com/CedX/Validation.ps1/blob/main/License.md"
			ProjectUri = "https://github.com/CedX/Validation.ps1"
			ReleaseNotes = "https://github.com/CedX/Validation.ps1/releases"
			Tags = "data", "dto", "validator", "validation"
		}
	}
}
