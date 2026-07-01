namespace Belin.Validation;

/// <summary>
/// A validator that compares a value to another reference value.
/// </summary>
/// <typeparam name="T">The type of the comparison value.</typeparam>
public class ComparisonValidator<T>: Validator {

	/// <summary>
	/// The comparison value.
	/// </summary>
	public required T Value { get; init; }
}
