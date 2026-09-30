namespace Belin.Validation.Validators

open Belin.Validation
open System.Management.Automation

/// Creates a new validator that ensures a collection length falls within a specified range.
[<Cmdlet(VerbsCommon.New, "ValidatorCount")>]
[<OutputType(typeof<Validator>)>]
type NewValidatorCountCommand() =
  inherit Cmdlet()

  /// The minimum required length.
  [<Parameter(Mandatory = true, Position = 1); ValidateRange(ValidateRangeKind.NonNegative)>]
  member val Min = 0 with get, set

  /// The maximum required length.
  [<Parameter(Mandatory = true, Position = 2); ValidateRange(ValidateRangeKind.NonNegative)>]
  member val Max = 0 with get, set

  /// The error message describing the validation failure.
  [<Parameter(Mandatory = true, Position = 3)>]
  member val Reason = "" with get, set

  /// Performs execution of this command.
  override this.ProcessRecord() =
    if this.Max < this.Min then invalidArg (nameof this.Max) "The maximum length is less than the minimum length."
    let scriptBlock = "($_.Count -ge $this.LowerBound) -and ($_.Count -le $this.UpperBound)"
    this.WriteObject (RangeValidator(this.Min, this.Max, this.Reason, ScriptBlock.Create scriptBlock))

/// Creates a new validator that ensures the validated value has a maximum length.
[<Cmdlet(VerbsCommon.New, "ValidatorMaxCount")>]
[<OutputType(typeof<Validator>)>]
type NewValidatorMaxCountCommand() =
  inherit Cmdlet()

  /// The maximum required length.
  [<Parameter(Mandatory = true, Position = 1); ValidateRange(ValidateRangeKind.NonNegative)>]
  member val Value = 0 with get, set

  /// The error message describing the validation failure.
  [<Parameter(Mandatory = true, Position = 2)>]
  member val Reason = "" with get, set

  /// Performs execution of this command.
  override this.ProcessRecord() =
    let scriptBlock = "$_.Count -le $this.Value"
    this.WriteObject (ComparisonValidator(this.Value, this.Reason, ScriptBlock.Create scriptBlock))

/// Creates a new validator that ensures the validated value has a minimum length.
[<Cmdlet(VerbsCommon.New, "ValidatorMinCount")>]
[<OutputType(typeof<Validator>)>]
type NewValidatorMinCountCommand() =
  inherit Cmdlet()

  /// The minimum required length.
  [<Parameter(Mandatory = true, Position = 1); ValidateRange(ValidateRangeKind.NonNegative)>]
  member val Value = 0 with get, set

  /// The error message describing the validation failure.
  [<Parameter(Mandatory = true, Position = 2)>]
  member val Reason = "" with get, set

  /// Performs execution of this command.
  override this.ProcessRecord() =
    let scriptBlock = "$_.Count -ge $this.Value"
    this.WriteObject (ComparisonValidator(this.Value, this.Reason, ScriptBlock.Create scriptBlock))
