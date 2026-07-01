namespace Belin.Validation;

/// <summary>
/// A validator that ensures that a value falls within a specified range.
/// </summary>
/// <typeparam name="T">The type of comparison values.</typeparam>
public class RangeValidator<T>: Validator {

	/// <summary>
	/// The lower bound.
	/// </summary>
	public required T LowerBound { get; init; }

	/// <summary>
	/// The upper bound.
	/// </summary>
	public required T UpperBound { get; init; }
}
