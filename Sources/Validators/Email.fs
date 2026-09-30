namespace Belin.Validation.Validators

open Belin.Validation
open System.Management.Automation

/// Creates a new validator that ensures the validated value is a well-formed mail address.
[<Cmdlet(VerbsCommon.New, "ValidatorEmail")>]
[<OutputType(typeof<Validator>)>]
type NewValidatorEmailCommand() =
  inherit Cmdlet()

  /// The error message describing the validation failure.
  [<Parameter(Mandatory = true, Position = 1)>]
  member val Reason = "" with get, set

  /// Performs execution of this command.
  override this.ProcessRecord() =
    let scriptBlock = """
      if (($_ -isnot [string]) -or ($_ -match "[\n\r]")) { return $false }
      $index = $_.IndexOf("@")
      ($index -gt 0) -and ($index -lt ($_.Length - 1)) -and ($index -eq $_.LastIndexOf("@"))
      """

    this.WriteObject (Validator(this.Reason, ScriptBlock.Create scriptBlock))
