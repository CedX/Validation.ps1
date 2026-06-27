namespace Belin.Validation;

using System.Collections;
using System.Globalization;
using System.Management.Automation;

/// <summary>
/// Performs data validation.
/// </summary>
public class Validator {

	/// <summary>
	/// The error message describing the validation failure.
	/// </summary>
	public required string Reason { get; set; }

	/// <summary>
	/// The script block used to perform the validation.
	/// </summary>
	public required ScriptBlock Test { get; set; }

	/// <summary>
	/// Returns a value indicating whether the specified value is valid according to this validator.
	/// </summary>
	/// <param name="value">The value to be validated.</param>
	/// <returns><see langword="true"/> if the specified value is valid otherwise <see langword="false"/>.</returns>
	public bool IsValid(object? value) => Convert.ToBoolean(Test.Invoke(value).Last().BaseObject, CultureInfo.InvariantCulture);

	/// <summary>
	/// Creates a new validator from the specified hash table.
	/// </summary>
	/// <param name="hashtable">The hash table providing the validator properties.</param>
	/// <returns>The validator corresponding to the specified hash table.</returns>
	/// <exception cref="ArgumentException">TODO</exception>
	public static implicit operator Validator(Hashtable hashtable) {
		return new Validator {
			Reason = hashtable["Reason"] is string reason ? reason : throw new ArgumentException("TODO", nameof(hashtable)),
			Test = hashtable["Test"] is ScriptBlock test ? test : throw new ArgumentException("TODO", nameof(hashtable))
		};
	}
}
