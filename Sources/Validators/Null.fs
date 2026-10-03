namespace Belin.Validation.Validators

open Belin.Validation
open System.Management.Automation

/// Creates a new validator that ensures the validated value is `$null`.
[<Cmdlet(VerbsCommon.New, "ValidatorNull"); OutputType(typeof<Validator>)>]
type NewValidatorNullCommand() =
  inherit Cmdlet()

  /// The script block used to perform the validation.
  static let scriptBlock = ScriptBlock.Create "$null -eq $_"

  /// The error message describing the validation failure.
  [<Parameter(Mandatory = true, Position = 1)>]
  member val Reason = "" with get, set

  /// Performs execution of this command.
  override this.ProcessRecord () = this.WriteObject (Validator (this.Reason, scriptBlock))

/// Creates a new validator that ensures the validated value is not `$null`.
[<Cmdlet(VerbsCommon.New, "ValidatorNotNull"); OutputType(typeof<Validator>)>]
type NewValidatorNotNullCommand() =
  inherit Cmdlet()

  /// The script block used to perform the validation.
  static let scriptBlock = ScriptBlock.Create "$null -ne $_"

  /// The error message describing the validation failure.
  [<Parameter(Mandatory = true, Position = 1)>]
  member val Reason = "" with get, set

  /// Performs execution of this command.
  override this.ProcessRecord () = this.WriteObject (Validator (this.Reason, scriptBlock))
