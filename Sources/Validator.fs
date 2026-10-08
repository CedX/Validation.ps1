namespace Belin.Validation

open System
open System.Collections
open System.Collections.Generic
open System.Globalization
open System.Management.Automation

/// A generic validator.
type Validator (reason: string, test: ScriptBlock) =

  /// The error message describing the validation failure.
  member val Reason: string = reason with get, set

  /// The script block used to perform the validation.
  member val Test: ScriptBlock = test

  /// Returns a value indicating whether the specified value is valid according to this validator.
  member this.IsValid (value: objnull): bool =
    let variables = List<PSVariable> 2
    variables.Add(PSVariable("this", this))
    variables.Add(PSVariable("_", value))

    let output = Seq.last (this.Test.InvokeWithContext(functionsToDefine = null, variablesToDefine = variables))
    Convert.ToBoolean (output.BaseObject, CultureInfo.InvariantCulture)

  /// Creates a new validator from the specified hash table.
  static member OfDictionary (hashtable: IDictionary) =
    let reason = match hashtable["Reason"] with :? string as value -> value | _ -> invalidArg (nameof hashtable) "Error message missing or invalid."
    let test = match hashtable["Test"] with :? ScriptBlock as script -> script | _ -> invalidArg (nameof hashtable) "Script block missing or invalid."
    Validator (reason, test)

/// A validator that compares a value to another reference value.
type ComparisonValidator (value: objnull, reason: string, test: ScriptBlock) =
  inherit Validator (reason, test)

  /// The comparison value.
  member val Value: objnull = value

/// A validator that ensures a value falls within a specified range.
type RangeValidator (lowerBound: IComparable, upperBound: IComparable, reason: string, test: ScriptBlock) =
  inherit Validator (reason, test)

  /// The lower bound.
  member val LowerBound: IComparable = lowerBound

  /// The upper bound.
  member val UpperBound: IComparable = upperBound

/// Creates a new validator.
[<Cmdlet(VerbsCommon.New, "Validator"); OutputType(typeof<Validator>)>]
type NewValidator() =
  inherit Cmdlet()

  /// The error message describing the validation failure.
  [<Parameter(Mandatory = true, Position = 1)>]
  member val Reason = "" with get, set

  /// The script block used to perform the validation.
  [<Parameter(Mandatory = true, Position = 2)>]
  member val Test = ScriptBlock.Create "return $false" with get, set

  /// Performs execution of this command.
  override this.ProcessRecord () = this.WriteObject (Validator (this.Reason, this.Test))
