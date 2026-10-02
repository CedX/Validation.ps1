namespace Belin.Validation.Validators

open Belin.Validation
open System.Management.Automation

/// Creates a new validator that ensures the validated value is a well-formed Base64 string.
[<Cmdlet(VerbsCommon.New, "ValidatorBase64")>]
[<OutputType(typeof<Validator>)>]
type NewValidatorBase64Command() =
  inherit Cmdlet()

  /// The script block used to perform the validation.
  static let base64ScriptBlock = ScriptBlock.Create "($_ -is [string]) -and [System.Buffers.Text.Base64]::IsValid($_)"

  /// The script block used to perform the validation.
  static let base64UrlScriptBlock = ScriptBlock.Create "($_ -is [string]) -and [System.Buffers.Text.Base64Url]::IsValid($_)"

  /// The error message describing the validation failure.
  [<Parameter(Mandatory = true, Position = 1)>]
  member val Reason = "" with get, set

  /// Value indicating whether the specified string uses a URL-safe alphabet.
  [<Parameter>]
  member val Url = SwitchParameter false with get, set

  /// Performs execution of this command.
  override this.ProcessRecord () =
    let scriptBlock = if this.Url.IsPresent then base64UrlScriptBlock else base64ScriptBlock
    this.WriteObject (Validator (this.Reason, scriptBlock))
