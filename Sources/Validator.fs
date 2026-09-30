namespace Belin.Validation

open System
open System.Collections
open System.Collections.Generic
open System.Globalization
open System.Management.Automation

/// A generic validator.
type Validator(reason: string, test: ScriptBlock) =

  /// The error message describing the validation failure.
  member val Reason = reason with get, set

  /// The script block used to perform the validation.
  member val Test: ScriptBlock = test

  /// Returns a value indicating whether the specified value is valid according to this validator.
  member this.IsValid(value: obj|null) =
    let variables = List<PSVariable> 2
    variables.Add(PSVariable("this", this))
    variables.Add(PSVariable("_", value))

    let output = Seq.last (this.Test.InvokeWithContext(null, variables))
    Convert.ToBoolean(output.BaseObject, CultureInfo.InvariantCulture)

  /// Creates a new validator from the specified hash table.
  static member OfHashtable (hashtable: Hashtable) =
    let reason = match hashtable["Reason"] with :? string as value -> value | _ -> invalidArg (nameof hashtable) "The error message is missing or invalid."
    let test = match hashtable["Test"] with :? ScriptBlock as value -> value | _ -> invalidArg (nameof hashtable) "The script block is missing or invalid."
    Validator(reason, test)

/// A validator that compares a value to another reference value.
type ComparisonValidator(reason: string, value: obj|null, test: ScriptBlock) =
  inherit Validator(reason, test)

  /// The comparison value.
  member val Value: obj|null = value

/// A validator that ensures a value falls within a specified range.
type RangeValidator(reason: string, lowerBound: obj, upperBound: obj, test: ScriptBlock) =
  inherit Validator(reason, test)

  /// The lower bound.
  member val LowerBound: obj = lowerBound

  /// The upper bound.
  member val UpperBound: obj = upperBound
