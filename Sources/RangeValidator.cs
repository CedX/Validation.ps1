namespace Belin.Validation;

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
