namespace Belin.Validation.Validators

open Belin.Validation
open System.Management.Automation

/// Creates a new validator that ensures the validated value exists in a specified enumeration.
[<Cmdlet(VerbsCommon.New, "ValidatorEnum")>]
[<OutputType(typeof<Validator>)>]
type NewValidatorEnumCommand() =
  inherit Cmdlet()

  /// An enumeration type.
  [<Parameter(Mandatory = true, Position = 1)>]
  member val Type = typeof<NewValidatorEnumCommand> with get, set

  /// The error message describing the validation failure.
  [<Parameter(Mandatory = true, Position = 2)>]
  member val Reason = "" with get, set

  /// Performs execution of this command.
  override this.ProcessRecord() =
    let scriptBlock = "[Enum]::IsDefined($this.Value, $_)"
    this.WriteObject (ComparisonValidator(this.Type, this.Reason, ScriptBlock.Create scriptBlock))
