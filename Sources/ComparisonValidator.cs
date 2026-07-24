namespace Belin.Validation;

/// <summary>
/// A validator that compares a value to another reference value.
/// </summary>
public class ComparisonValidator: Validator {

	/// <summary>
	/// The comparison value.
	/// </summary>
	public required object? Value { get; init; }
}
