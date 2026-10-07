namespace Belin.Validation.Validators

open Belin.Validation
open System.Management.Automation

/// Creates a new validator that ensures the validated value matches an element from a set of possible values.
[<Cmdlet(VerbsCommon.New, "ValidatorIn"); OutputType(typeof<Validator>)>]
type NewValidatorIn() =
  inherit Cmdlet()

  /// The script block used to perform the validation.
  static let insensitiveScriptBlock = ScriptBlock.Create "$_ -iin $this.Value"

  /// The script block used to perform the validation.
  static let sensitiveScriptBlock = ScriptBlock.Create "$_ -cin $this.Value"

  /// The set of possible values.
  [<Parameter(Mandatory = true, Position = 1)>]
  member val Values: objnull array = [||] with get, set

  /// The error message describing the validation failure.
  [<Parameter(Mandatory = true, Position = 2)>]
  member val Reason = "" with get, set

  /// Value indicating whether to perform a case-sensitive comparison.
  [<Parameter>]
  member val CaseSensitive = SwitchParameter false with get, set

  /// Performs execution of this command.
  override this.ProcessRecord () =
    let scriptBlock = if this.CaseSensitive.IsPresent then sensitiveScriptBlock else insensitiveScriptBlock
    this.WriteObject (ComparisonValidator (this.Values, this.Reason, scriptBlock))

/// Creates a new validator that ensures the validated value does not match an element from a set of possible values.
[<Cmdlet(VerbsCommon.New, "ValidatorNotIn"); OutputType(typeof<Validator>)>]
type NewValidatorNotIn() =
  inherit Cmdlet()

  /// The script block used to perform the validation.
  static let insensitiveScriptBlock = ScriptBlock.Create "$_ -inotin $this.Value"

  /// The script block used to perform the validation.
  static let sensitiveScriptBlock = ScriptBlock.Create "$_ -cnotin $this.Value"

  /// The set of possible values.
  [<Parameter(Mandatory = true, Position = 1)>]
  member val Values: objnull array = [||] with get, set

  /// The error message describing the validation failure.
  [<Parameter(Mandatory = true, Position = 2)>]
  member val Reason = "" with get, set

  /// Value indicating whether to perform a case-sensitive comparison.
  [<Parameter>]
  member val CaseSensitive = SwitchParameter false with get, set

  /// Performs execution of this command.
  override this.ProcessRecord () =
    let scriptBlock = if this.CaseSensitive.IsPresent then sensitiveScriptBlock else insensitiveScriptBlock
    this.WriteObject (ComparisonValidator (this.Values, this.Reason, scriptBlock))
