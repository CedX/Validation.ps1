namespace Belin.Validation.Validators

open Belin.Validation
open System.Management.Automation

/// Creates a new validator that ensures the validated value matches a given wildcard pattern.
[<Cmdlet(VerbsCommon.New, "ValidatorLike")>]
[<OutputType(typeof<Validator>)>]
type NewValidatorLikeCommand() =
  inherit Cmdlet()

  /// The script block used to perform the validation.
  static let insensitiveScriptBlock =
    ScriptBlock.Create "$_ -ilike $this.Value"

  /// The script block used to perform the validation.
  static let sensitiveScriptBlock =
    ScriptBlock.Create "$_ -clike $this.Value"

  /// The pattern to match.
  [<Parameter(Mandatory = true, Position = 1)>]
  member val Pattern = "" with get, set

  /// The error message describing the validation failure.
  [<Parameter(Mandatory = true, Position = 2)>]
  member val Reason = "" with get, set

  /// Value indicating whether to perform a case-sensitive comparison.
  [<Parameter>]
  member val CaseSensitive = SwitchParameter(isPresent = false) with get, set

  /// Performs execution of this command.
  override this.ProcessRecord() =
    let scriptBlock = if this.CaseSensitive.IsPresent then sensitiveScriptBlock else insensitiveScriptBlock
    this.WriteObject (ComparisonValidator(this.Pattern, this.Reason, scriptBlock))

/// Creates a new validator that ensures the validated value does not match a given wildcard pattern.
[<Cmdlet(VerbsCommon.New, "ValidatorNotLike")>]
[<OutputType(typeof<Validator>)>]
type NewValidatorNotLikeCommand() =
  inherit Cmdlet()

  /// The script block used to perform the validation.
  static let insensitiveScriptBlock =
    ScriptBlock.Create "$_ -inotlike $this.Value"

  /// The script block used to perform the validation.
  static let sensitiveScriptBlock =
    ScriptBlock.Create "$_ -cnotlike $this.Value"

  /// The pattern to match.
  [<Parameter(Mandatory = true, Position = 1)>]
  member val Pattern = "" with get, set

  /// The error message describing the validation failure.
  [<Parameter(Mandatory = true, Position = 2)>]
  member val Reason = "" with get, set

  /// Value indicating whether to perform a case-sensitive comparison.
  [<Parameter>]
  member val CaseSensitive = SwitchParameter(isPresent = false) with get, set

  /// Performs execution of this command.
  override this.ProcessRecord() =
    let scriptBlock = if this.CaseSensitive.IsPresent then sensitiveScriptBlock else insensitiveScriptBlock
    this.WriteObject (ComparisonValidator(this.Pattern, this.Reason, scriptBlock))
