using module PSScriptAnalyzer

"Performing the static analysis of source code..."
$PSScriptRoot, "Sources", "Tests" | Invoke-ScriptAnalyzer -Recurse
Test-ModuleManifest Validation.psd1 | Out-Null
