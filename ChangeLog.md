# Changelog

## Version [1.0.0](https://github.com/CedX/Validation.ps1/compare/v0.7.1...v1.0.0)
- Fixed the handling of `[PSObject]` instances.
- First stable release.

## Version [0.7.1](https://github.com/CedX/Validation.ps1/compare/v0.7.0...v0.7.1)
- Fixed the `Assert-Validation` and `Test-Validation` cmdlets when the input object is wrapped into a `[PSObject]`.

## Version [0.7.0](https://github.com/CedX/Validation.ps1/compare/v0.6.1...v0.7.0)
- Ported the cmdlets to [F#](https://learn.microsoft.com/en-us/dotnet/fsharp).

## Version [0.6.1](https://github.com/CedX/Validation.ps1/compare/v0.6.0...v0.6.1)
- Optimized the packaging.

## Version [0.6.0](https://github.com/CedX/Validation.ps1/compare/v0.5.0...v0.6.0)
- Added the `New-ValidatorEnum` cmdlet.

## Version [0.5.0](https://github.com/CedX/Validation.ps1/compare/v0.4.0...v0.5.0)
- Breaking change: renamed the `Test-Validation` cmdlet to `Assert-Validation`.
- Added a new `Test-Validation` cmdlet returning a boolean value instead of error messages.

## Version [0.4.0](https://github.com/CedX/Validation.ps1/compare/v0.3.0...v0.4.0)
- Breaking change: removed the `New-ValidatorIban` cmdlet.
- Added the `New-ValidatorCount`, `New-ValidatorMaxCount`, `New-ValidatorMinCount` and `New-ValidatorUri` cmdlets.

## Version [0.3.0](https://github.com/CedX/Validation.ps1/compare/v0.2.0...v0.3.0)
- Added the `New-ValidatorBase64`, `New-ValidatorEmail` and `New-ValidatorIban` cmdlets.

## Version [0.2.0](https://github.com/CedX/Validation.ps1/compare/v0.1.1...v0.2.0)
- Added the `New-ValidatorCreditCard`, `New-ValidatorIn` and `New-ValidatorNotIn` cmdlets.

## Version [0.1.1](https://github.com/CedX/Validation.ps1/compare/v0.1.0...v0.1.1)
- Fixed a packaging issue.

## Version 0.1.0
- Initial release.
