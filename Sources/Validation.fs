namespace Belin.Validation

open System
open System.Collections
open System.Management.Automation

/// Contains operations for working with validation rules.
module private Validation =

  /// Gets the value of the specified property of a given object.
  let getValue (input: obj) (property: string): objnull =
    let baseObject = match input with :? PSObject as psObject -> psObject.BaseObject | value -> value
    match baseObject with
    | :? IDictionary as dictionary -> dictionary[property]
    | _ ->
      match input with
      | :? PSObject as psObject -> match psObject.Properties[property] with null -> null | propertyInfo -> propertyInfo.Value
      | _ -> match input.GetType().GetProperty property with null -> null | propertyInfo -> propertyInfo.GetValue input

  /// Ensures that the specified value is an array.
  /// The result is always an array of zero or more objects.
  let toArray (input: objnull): obj array =
    match input with
    | null -> [||]
    | :? (obj array) as objectArray -> objectArray
    | :? (obj seq) as objectSequence -> Seq.toArray objectSequence
    | element -> [| element |]

  /// Converts the specified validation rule to a `Validator` object.
  let toValidator (property: string) (rule: obj): Validator =
    match rule with
    | :? Hashtable as hashtable -> Validator.OfHashtable hashtable
    | :? Validator as validator -> validator
    | _ -> invalidArg "RuleSet" $"""The "{property}" property has a validator of an unsupported type."""

/// Performs the data validation on the specified object according to a given set of validation rules.
/// Returns the validation errors, if any.
[<Cmdlet(VerbsLifecycle.Assert, "Validation")>]
[<OutputType(typeof<Hashtable>)>]
type AssertValidationCommand () =
  inherit Cmdlet ()

  /// The object to validate.
  [<Parameter(Mandatory = true, Position = 1, ValueFromPipeline = true)>]
  member val InputObject: obj = Object () with get, set

  /// The set of validation rules to apply.
  [<Parameter(Mandatory = true, Position = 2)>]
  member val RuleSet: IDictionary = Hashtable() with get, set

  /// Performs execution of this command.
  override this.ProcessRecord () =
    let errors = Hashtable()

    for key in this.RuleSet.Keys do
      let property = string key
      let rules = Validation.toArray this.RuleSet[property]

      let mutable ruleIndex = 0
      while not (errors.ContainsKey property) && ruleIndex < rules.Length do
        let rule = match rules[ruleIndex] with :? PSObject as value -> value.BaseObject | value -> value
        ruleIndex <- ruleIndex + 1

        let validator = Validation.toValidator property rule
        let value = Validation.getValue this.InputObject property
        if not (validator.IsValid value) then errors[property] <- validator.Reason

    this.WriteObject errors

/// Performs the data validation on the specified object according to a given set of validation rules.
/// Returns `true` if the validated object is valid, otherwise `false`.
[<Cmdlet(VerbsDiagnostic.Test, "Validation")>]
[<OutputType(typeof<bool>)>]
type TestValidationCommand () =
  inherit Cmdlet ()

  /// The object to validate.
  [<Parameter(Mandatory = true, Position = 1, ValueFromPipeline = true)>]
  member val InputObject: obj = Object () with get, set

  /// The set of validation rules to apply.
  [<Parameter(Mandatory = true, Position = 2)>]
  member val RuleSet: IDictionary = Hashtable() with get, set

  /// Performs execution of this command.
  override this.ProcessRecord () =
    let mutable isValid = true
    let keys = this.RuleSet.Keys |> Seq.cast<string> |> Array.ofSeq

    let mutable keyIndex = 0
    while isValid && keyIndex < keys.Length do
      let property = keys[keyIndex]
      let rules = Validation.toArray this.RuleSet[property]
      keyIndex <- keyIndex + 1

      let mutable ruleIndex = 0
      while isValid && ruleIndex < rules.Length do
        let rule = match rules[ruleIndex] with :? PSObject as psObject -> psObject.BaseObject | value -> value
        ruleIndex <- ruleIndex + 1

        let validator = Validation.toValidator property rule
        let value = Validation.getValue this.InputObject property
        if not (validator.IsValid value) then isValid <- false

    this.WriteObject isValid
