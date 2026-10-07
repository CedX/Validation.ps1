namespace Belin.Validation.Validators

open Belin.Validation
open System.Management.Automation

/// Creates a new validator that ensures the validated value is empty.
[<Cmdlet(VerbsCommon.New, "ValidatorEmpty"); OutputType(typeof<Validator>)>]
type NewValidatorEmpty() =
  inherit Cmdlet()

  /// The script block used to perform the validation.
  static let scriptBlock =
    ScriptBlock.Create """
      if ($_ -is [string]) { return [string]::IsNullOrWhiteSpace($_) }
      if ($_ -is [System.Collections.ICollection]) { return $_.Count -eq 0 }
      if ($_ -is [System.Collections.IEnumerable]) { return -not $_.GetEnumerator().MoveNext() }
      -not [bool] $_
      """

  /// The error message describing the validation failure.
  [<Parameter(Mandatory = true, Position = 1)>]
  member val Reason = "" with get, set

  /// Performs execution of this command.
  override this.ProcessRecord () = this.WriteObject (Validator (this.Reason, scriptBlock))

/// Creates a new validator that ensures the validated value is not empty.
[<Cmdlet(VerbsCommon.New, "ValidatorNotEmpty"); OutputType(typeof<Validator>)>]
type NewValidatorNotEmpty() =
  inherit Cmdlet()

  /// The script block used to perform the validation.
  static let scriptBlock =
    ScriptBlock.Create """
      if ($_ -is [string]) { return -not [string]::IsNullOrWhiteSpace($_) }
      if ($_ -is [System.Collections.ICollection]) { return $_.Count -gt 0 }
      if ($_ -is [System.Collections.IEnumerable]) { return $_.GetEnumerator().MoveNext() }
      [bool] $_
      """

  /// The error message describing the validation failure.
  [<Parameter(Mandatory = true, Position = 1)>]
  member val Reason = "" with get, set

  /// Performs execution of this command.
  override this.ProcessRecord () = this.WriteObject (Validator (this.Reason, scriptBlock))
