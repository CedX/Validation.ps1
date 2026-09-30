namespace Belin.Validation.Validators

open Belin.Validation
open System.Management.Automation

/// Creates a new validator that ensures the validated value is less than a specific value.
[<Cmdlet(VerbsCommon.New, "ValidatorLessThan")>]
[<OutputType(typeof<Validator>)>]
type NewValidatorLessThanCommand () =
  inherit Cmdlet ()

  /// The script block used to perform the validation.
  static let insensitiveScriptBlock = ScriptBlock.Create "$_ -ilt $this.Value"

  /// The script block used to perform the validation.
  static let sensitiveScriptBlock = ScriptBlock.Create "$_ -clt $this.Value"

  /// The value to compare.
  [<Parameter(Mandatory = true, Position = 1); AllowEmptyString; AllowNull>]
  member val Value: obj | null = null with get, set

  /// The error message describing the validation failure.
  [<Parameter(Mandatory = true, Position = 2)>]
  member val Reason = "" with get, set

  /// Value indicating whether to perform a case-sensitive comparison.
  [<Parameter>]
  member val CaseSensitive = SwitchParameter false with get, set

  /// Performs execution of this command.
  override this.ProcessRecord () =
    let scriptBlock = if this.CaseSensitive.IsPresent then sensitiveScriptBlock else insensitiveScriptBlock
    this.WriteObject (ComparisonValidator (this.Value, this.Reason, scriptBlock))

/// Creates a new validator that ensures the validated value is less than or equal to a specific value.
[<Cmdlet(VerbsCommon.New, "ValidatorLessThanOrEqual")>]
[<OutputType(typeof<Validator>)>]
type NewValidatorLessThanOrEqualCommand () =
  inherit Cmdlet ()

  /// The script block used to perform the validation.
  static let insensitiveScriptBlock = ScriptBlock.Create "$_ -cle $this.Value"

  /// The script block used to perform the validation.
  static let sensitiveScriptBlock = ScriptBlock.Create "$_ -ile $this.Value"

  /// The value to compare.
  [<Parameter(Mandatory = true, Position = 1); AllowEmptyString; AllowNull>]
  member val Value: obj | null = null with get, set

  /// The error message describing the validation failure.
  [<Parameter(Mandatory = true, Position = 2)>]
  member val Reason = "" with get, set

  /// Value indicating whether to perform a case-sensitive comparison.
  [<Parameter>]
  member val CaseSensitive = SwitchParameter false with get, set

  /// Performs execution of this command.
  override this.ProcessRecord () =
    let scriptBlock = if this.CaseSensitive.IsPresent then sensitiveScriptBlock else insensitiveScriptBlock
    this.WriteObject (ComparisonValidator (this.Value, this.Reason, scriptBlock))
