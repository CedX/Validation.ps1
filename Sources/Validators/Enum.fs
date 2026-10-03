namespace Belin.Validation.Validators

open Belin.Validation
open System.Management.Automation

/// Creates a new validator that ensures the validated value exists in a specified enumeration.
[<Cmdlet(VerbsCommon.New, "ValidatorEnum"); OutputType(typeof<Validator>)>]
type NewValidatorEnumCommand() =
  inherit Cmdlet()

  /// The script block used to perform the validation.
  static let scriptBlock = ScriptBlock.Create "[Enum]::IsDefined($this.Value, $_)"

  /// An enumeration type.
  [<Parameter(Mandatory = true, Position = 1)>]
  member val Type = typeof<NewValidatorEnumCommand> with get, set

  /// The error message describing the validation failure.
  [<Parameter(Mandatory = true, Position = 2)>]
  member val Reason = "" with get, set

  /// Performs execution of this command.
  override this.ProcessRecord () = this.WriteObject (ComparisonValidator (this.Type, this.Reason, scriptBlock))
