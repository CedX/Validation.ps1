namespace Belin.Validation;

using System.Collections;
using System.Globalization;
using System.Management.Automation;

/// <summary>
/// Performs data validation.
/// </summary>
public interface IValidator {

	/// <summary>
	/// The error message describing the validation failure.
	/// </summary>
	string Reason { get; }

	/// <summary>
	/// The script block used to perform the validation.
	/// </summary>
	ScriptBlock Test { get; }

	/// <summary>
	/// Returns a value indicating whether the specified value is valid according to this validator.
	/// </summary>
	/// <param name="value">The value to be validated.</param>
	/// <returns><see langword="true"/> if the specified value is valid otherwise <see langword="false"/>.</returns>
	bool IsValid(object? value);
}

/// <summary>
/// A generic validator.
/// </summary>
public class Validator: IValidator {

	/// <summary>
	/// The error message describing the validation failure.
	/// </summary>
	public required string Reason { get; set; }

	/// <summary>
	/// The script block used to perform the validation.
	/// </summary>
	public required ScriptBlock Test { get; init; }

	/// <summary>
	/// Returns a value indicating whether the specified value is valid according to this validator.
	/// </summary>
	/// <param name="value">The value to be validated.</param>
	/// <returns><see langword="true"/> if the specified value is valid otherwise <see langword="false"/>.</returns>
	public bool IsValid(object? value) {
		var variables = new List<PSVariable> { new("this", this), new("_", value) };
		var output = Test.InvokeWithContext(functionsToDefine: null, variablesToDefine: variables);
		return Convert.ToBoolean(output.Last().BaseObject, CultureInfo.InvariantCulture);
	}

	/// <summary>
	/// Creates a new validator from the specified hash table.
	/// </summary>
	/// <param name="hashtable">The hash table providing the validator properties.</param>
	/// <returns>The validator corresponding to the specified hash table.</returns>
	/// <exception cref="ArgumentException">The error message or the script block is missing or invalid.</exception>
	public static implicit operator Validator(Hashtable hashtable) => new() {
		Reason = hashtable["Reason"] is string reason ? reason : throw new ArgumentException("The error message is missing or invalid.", nameof(hashtable)),
		Test = hashtable["Test"] is ScriptBlock test ? test : throw new ArgumentException("The script block is missing or invalid.", nameof(hashtable))
	};
}
