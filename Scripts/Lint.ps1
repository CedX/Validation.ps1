using module PSScriptAnalyzer
using module ./Cmdlets.psm1

"Performing the static analysis of source code..."
Invoke-FSharpLint Validation.slnx -Configuration Configuration/FSharpLint.json
$PSScriptRoot, "Tests" | Invoke-ScriptAnalyzer -ExcludeRule PSAvoidUsingPositionalParameters -Recurse
Test-ModuleManifest Validation.psd1 | Out-Null
