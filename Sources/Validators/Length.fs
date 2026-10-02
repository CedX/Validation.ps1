namespace Belin.Validation.Validators

open Belin.Validation
open System.Management.Automation

/// Creates a new validator that ensures a string length falls within a specified range.
[<Cmdlet(VerbsCommon.New, "ValidatorLength")>]
[<OutputType(typeof<Validator>)>]
type NewValidatorLengthCommand() =
  inherit Cmdlet()

  /// The script block used to perform the validation.
  static let scriptBlock =
    ScriptBlock.Create "($_ -is [string]) -and ($_.Length -ge $this.LowerBound) -and ($_.Length -le $this.UpperBound)"

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
  override this.ProcessRecord () =
    if this.Max < this.Min then invalidArg (nameof this.Max) "The maximum length is less than the minimum length."
    this.WriteObject (RangeValidator (this.Min, this.Max, this.Reason, scriptBlock))

/// Creates a new validator that ensures the validated string has a maximum length.
[<Cmdlet(VerbsCommon.New, "ValidatorMaxLength")>]
[<OutputType(typeof<Validator>)>]
type NewValidatorMaxLengthCommand() =
  inherit Cmdlet()

  /// The script block used to perform the validation.
  static let scriptBlock = ScriptBlock.Create "($_ -is [string]) -and ($_.Length -le $this.Value)"

  /// The maximum required length.
  [<Parameter(Mandatory = true, Position = 1); ValidateRange(ValidateRangeKind.NonNegative)>]
  member val Value = 0 with get, set

  /// The error message describing the validation failure.
  [<Parameter(Mandatory = true, Position = 2)>]
  member val Reason = "" with get, set

  /// Performs execution of this command.
  override this.ProcessRecord () = this.WriteObject (ComparisonValidator (this.Value, this.Reason, scriptBlock))

/// Creates a new validator that ensures the validated string has a minimum length.
[<Cmdlet(VerbsCommon.New, "ValidatorMinLength")>]
[<OutputType(typeof<Validator>)>]
type NewValidatorMinLengthCommand() =
  inherit Cmdlet()

  /// The script block used to perform the validation.
  static let scriptBlock = ScriptBlock.Create "($_ -is [string]) -and ($_.Length -ge $this.Value)"

  /// The minimum required length.
  [<Parameter(Mandatory = true, Position = 1); ValidateRange(ValidateRangeKind.NonNegative)>]
  member val Value = 0 with get, set

  /// The error message describing the validation failure.
  [<Parameter(Mandatory = true, Position = 2)>]
  member val Reason = "" with get, set

  /// Performs execution of this command.
  override this.ProcessRecord () = this.WriteObject (ComparisonValidator (this.Value, this.Reason, scriptBlock))
