namespace Belin.Validation.Validators

open Belin.Validation
open System.Management.Automation

/// Creates a new validator that ensures the validated value matches a given regex pattern.
[<Cmdlet(VerbsCommon.New, "ValidatorMatch")>]
[<OutputType(typeof<Validator>)>]
type NewValidatorMatchCommand () =
  inherit Cmdlet ()

  /// The script block used to perform the validation.
  static let insensitiveScriptBlock = ScriptBlock.Create "$_ -imatch $this.Value"

  /// The script block used to perform the validation.
  static let sensitiveScriptBlock = ScriptBlock.Create "$_ -cmatch $this.Value"

  /// The pattern to match.
  [<Parameter(Mandatory = true, Position = 1)>]
  member val Pattern = "" with get, set

  /// The error message describing the validation failure.
  [<Parameter(Mandatory = true, Position = 2)>]
  member val Reason = "" with get, set

  /// Value indicating whether to perform a case-sensitive comparison.
  [<Parameter>]
  member val CaseSensitive = SwitchParameter false with get, set

  /// Performs execution of this command.
  override this.ProcessRecord () =
    let scriptBlock = if this.CaseSensitive.IsPresent then sensitiveScriptBlock else insensitiveScriptBlock
    this.WriteObject (ComparisonValidator (this.Pattern, this.Reason, scriptBlock))

/// Creates a new validator that ensures the validated value does not match a given regex pattern.
[<Cmdlet(VerbsCommon.New, "ValidatorNotMatch")>]
[<OutputType(typeof<Validator>)>]
type NewValidatorNotMatchCommand () =
  inherit Cmdlet ()

  /// The script block used to perform the validation.
  static let insensitiveScriptBlock = ScriptBlock.Create "$_ -inotmatch $this.Value"

  /// The script block used to perform the validation.
  static let sensitiveScriptBlock = ScriptBlock.Create "$_ -cnotmatch $this.Value"

  /// The pattern to match.
  [<Parameter(Mandatory = true, Position = 1)>]
  member val Pattern = "" with get, set

  /// The error message describing the validation failure.
  [<Parameter(Mandatory = true, Position = 2)>]
  member val Reason = "" with get, set

  /// Value indicating whether to perform a case-sensitive comparison.
  [<Parameter>]
  member val CaseSensitive = SwitchParameter false with get, set

  /// Performs execution of this command.
  override this.ProcessRecord () =
    let scriptBlock = if this.CaseSensitive.IsPresent then sensitiveScriptBlock else insensitiveScriptBlock
    this.WriteObject (ComparisonValidator (this.Pattern, this.Reason, scriptBlock))
