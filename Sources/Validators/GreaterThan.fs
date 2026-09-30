namespace Belin.Validation.Validators

open Belin.Validation
open System.Management.Automation

/// Creates a new validator that ensures the validated value is greater than a specific value.
[<Cmdlet(VerbsCommon.New, "ValidatorGreaterThan")>]
[<OutputType(typeof<Validator>)>]
type NewValidatorGreaterThanCommand() =
  inherit Cmdlet()

  /// The script block used to perform the validation.
  static let insensitiveScriptBlock = ScriptBlock.Create "$_ -igt $this.Value"

  /// The script block used to perform the validation.
  static let sensitiveScriptBlock = ScriptBlock.Create "$_ -cgt $this.Value"

  /// The value to compare.
  [<Parameter(Mandatory = true, Position = 1); AllowEmptyString; AllowNull>]
  member val Value: obj|null = null with get, set

  /// The error message describing the validation failure.
  [<Parameter(Mandatory = true, Position = 2)>]
  member val Reason = "" with get, set

  /// Value indicating whether to perform a case-sensitive comparison.
  [<Parameter>]
  member val CaseSensitive = SwitchParameter false with get, set

  /// Performs execution of this command.
  override this.ProcessRecord() =
    let scriptBlock = if this.CaseSensitive.IsPresent then sensitiveScriptBlock else insensitiveScriptBlock
    this.WriteObject (ComparisonValidator(this.Value, this.Reason, scriptBlock))

/// Creates a new validator that ensures the validated value is greater than or equal to a specific value.
[<Cmdlet(VerbsCommon.New, "ValidatorGreaterThanOrEqual")>]
[<OutputType(typeof<Validator>)>]
type NewValidatorGreaterThanOrEqualCommand() =
  inherit Cmdlet()

  /// The script block used to perform the validation.
  static let insensitiveScriptBlock = ScriptBlock.Create "$_ -cge $this.Value"

  /// The script block used to perform the validation.
  static let sensitiveScriptBlock = ScriptBlock.Create "$_ -ige $this.Value"

  /// The value to compare.
  [<Parameter(Mandatory = true, Position = 1); AllowEmptyString; AllowNull>]
  member val Value: obj|null = null with get, set

  /// The error message describing the validation failure.
  [<Parameter(Mandatory = true, Position = 2)>]
  member val Reason = "" with get, set

  /// Value indicating whether to perform a case-sensitive comparison.
  [<Parameter>]
  member val CaseSensitive = SwitchParameter false with get, set

  /// Performs execution of this command.
  override this.ProcessRecord() =
    let scriptBlock = if this.CaseSensitive.IsPresent then sensitiveScriptBlock else insensitiveScriptBlock
    this.WriteObject (ComparisonValidator(this.Value, this.Reason, scriptBlock))
