namespace Belin.Validation.Validators

open Belin.Validation
open System.Management.Automation

/// Creates a new validator that ensures the validated value is a well-formed Base64 string.
[<Cmdlet(VerbsCommon.New, "ValidatorBase64")>]
[<OutputType(typeof<Validator>)>]
type NewValidatorBase64Command() =
  inherit Cmdlet()

  /// The error message describing the validation failure.
  [<Parameter(Mandatory = true, Position = 1)>]
  member val Reason = "" with get, set

  /// Value indicating whether the specified string uses a URL-safe alphabet.
  [<Parameter>]
  member val Url = SwitchParameter(isPresent = false) with get, set

  /// Performs execution of this command.
  override this.ProcessRecord() =
    let scriptBlock =
      if this.Url.IsPresent then "($_ -is [string]) -and [System.Buffers.Text.Base64Url]::IsValid($_)"
      else "($_ -is [string]) -and [System.Buffers.Text.Base64]::IsValid($_)"

    this.WriteObject (Validator(this.Reason, ScriptBlock.Create scriptBlock))
