namespace Belin.Validation;

using System.Collections;
using System.Globalization;
using System.Management.Automation;

/// <summary>
/// A generic validator.
/// </summary>
public class Validator {

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
	public static explicit operator Validator(Hashtable hashtable) => new() {
		Reason = hashtable["Reason"] is string reason ? reason : throw new ArgumentException("The error message is missing or invalid.", nameof(hashtable)),
		Test = hashtable["Test"] is ScriptBlock test ? test : throw new ArgumentException("The script block is missing or invalid.", nameof(hashtable))
	};
}

/// <summary>
/// A validator that compares a value to another reference value.
/// </summary>
public class ComparisonValidator: Validator {

	/// <summary>
	/// The comparison value.
	/// </summary>
	public required object? Value { get; init; }
}

/// <summary>
/// A validator that ensures a value falls within a specified range.
/// </summary>
public class RangeValidator: Validator {

	/// <summary>
	/// The lower bound.
	/// </summary>
	public required object LowerBound { get; init; }

	/// <summary>
	/// The upper bound.
	/// </summary>
	public required object UpperBound { get; init; }
}
