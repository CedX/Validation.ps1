namespace Belin.Validation.Validators

open Belin.Validation
open System.Management.Automation

/// Creates a new validator that ensures the validated value is equal to a specific value.
[<Cmdlet(VerbsCommon.New, "ValidatorEqual")>]
[<OutputType(typeof<Validator>)>]
type NewValidatorEqualCommand() =
  inherit Cmdlet()

  /// The script block used to perform the validation.
  static let insensitiveScriptBlock = ScriptBlock.Create "$_ -ieq $this.Value"

  /// The script block used to perform the validation.
  static let sensitiveScriptBlock = ScriptBlock.Create "$_ -ceq $this.Value"

  /// The value to compare.
  [<Parameter(Mandatory = true, Position = 1); AllowEmptyString; AllowNull>]
  member val Value: objnull = null with get, set

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

/// Creates a new validator that ensures the validated value is not equal to a specific value.
[<Cmdlet(VerbsCommon.New, "ValidatorNotEqual")>]
[<OutputType(typeof<Validator>)>]
type NewValidatorNotEqualCommand() =
  inherit Cmdlet()

  /// The script block used to perform the validation.
  static let insensitiveScriptBlock = ScriptBlock.Create "$_ -ine $this.Value"

  /// The script block used to perform the validation.
  static let sensitiveScriptBlock = ScriptBlock.Create "$_ -cne $this.Value"

  /// The value to compare.
  [<Parameter(Mandatory = true, Position = 1); AllowEmptyString; AllowNull>]
  member val Value: objnull = null with get, set

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
