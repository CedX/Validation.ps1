namespace Belin.Validation.Validators

open Belin.Validation
open System
open System.Management.Automation

/// Creates a new validator that ensures a number falls within a specified range.
[<Cmdlet(VerbsCommon.New, "ValidatorRange"); OutputType(typeof<Validator>)>]
type NewValidatorRange() =
  inherit Cmdlet()

  /// The script block used to perform the validation.
  static let exclusiveScriptBlock = ScriptBlock.Create "($_ -gt $this.LowerBound) -and ($_ -lt $this.UpperBound)"

  /// The script block used to perform the validation.
  static let inclusiveScriptBlock = ScriptBlock.Create "($_ -ge $this.LowerBound) -and ($_ -le $this.UpperBound)"

  /// The minimum value of the range allowed.
  [<Parameter(Mandatory = true, Position = 1)>]
  member val From: IComparable = 0 with get, set

  /// The maximum value of the range allowed.
  [<Parameter(Mandatory = true, Position = 2)>]
  member val To: IComparable = 0 with get, set

  /// The error message describing the validation failure.
  [<Parameter(Mandatory = true, Position = 3)>]
  member val Reason = "" with get, set

  /// Value indicating whether the specified range is exclusive.
  [<Parameter>]
  member val Exclusive = SwitchParameter false with get, set

  /// Performs execution of this command.
  override this.ProcessRecord () =
    if this.To < this.From then invalidArg (nameof this.To) "The maximum value is less than the minimum value."
    let scriptBlock = if this.Exclusive.IsPresent then exclusiveScriptBlock else inclusiveScriptBlock
    this.WriteObject (RangeValidator (this.From, this.To, this.Reason, scriptBlock))
