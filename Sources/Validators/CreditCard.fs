namespace Belin.Validation.Validators

open Belin.Validation
open System.Management.Automation

/// Creates a new validator that ensures the validated value is a well-formed credit card number.
[<Cmdlet(VerbsCommon.New, "ValidatorCreditCard")>]
[<OutputType(typeof<Validator>)>]
type NewValidatorCreditCardCommand() =
  inherit Cmdlet()

  /// The script block used to perform the validation.
  static let scriptBlock =
    ScriptBlock.Create """
      $number = $_ -replace "[-. ]"
      if ($number -notmatch "^\d{8,19}$") { return $false }

      $characters = $number.ToCharArray()
      [array]::Reverse($characters)

      $checksum = 0
      $evenDigit = $false

      $characters | ForEach-Object {
        $digit = ($_ - [char] "0") * ($evenDigit ? 2 : 1)
        $evenDigit = -not $evenDigit

        while ($digit -gt 0) {
          $checksum += $digit % 10
          $digit = [int] [Math]::Truncate($digit / 10)
        }
      }

      ($checksum % 10) -eq 0
      """

  /// The error message describing the validation failure.
  [<Parameter(Mandatory = true, Position = 1)>]
  member val Reason = "" with get, set

  /// Performs execution of this command.
  override this.ProcessRecord () = this.WriteObject (Validator (this.Reason, scriptBlock))
