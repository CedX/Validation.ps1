namespace Belin.Validation.Validators

open Belin.Validation
open System.Management.Automation

/// Creates a new validator that ensures the validated value is a well-formed absolute URI.
[<Cmdlet(VerbsCommon.New, "ValidatorUri")>]
[<OutputType(typeof<Validator>)>]
type NewValidatorUriCommand() =
  inherit Cmdlet()

  /// The error message describing the validation failure.
  [<Parameter(Mandatory = true, Position = 1)>]
  member val Reason = "" with get, set

  /// The allowed schemes for the URI to validate.
  [<Parameter(Position = 2); ValidateNotNullOrEmpty>]
  member val Scheme = [| "http"; "https" |] with get, set

  /// Performs execution of this command.
  override this.ProcessRecord() =
    let scriptBlock = "([uri]::IsWellFormedUriString($_, [UriKind]::Absolute)) -and ([uri]::new($_).Scheme -in $this.Value)"
    this.WriteObject (ComparisonValidator(this.Scheme, this.Reason, ScriptBlock.Create scriptBlock))
