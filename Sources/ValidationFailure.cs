namespace Belin.Validation;

/// <summary>
/// Represents a validation failure.
/// </summary>
public class ValidationFailure {

	/// <summary>
	/// The property value that caused the failure.
	/// </summary>
	public required object? AttemptedValue { get; set; }

	/// <summary>
	/// The error message describing the validation failure.
	/// </summary>
	public required string ErrorMessage { get; set; }

	/// <summary>
	/// The name of the validated property.
	/// </summary>
	public required string PropertyName { get; set; }

	/// <summary>
	/// Returns a string representation of this object.
	/// </summary>
	/// <returns>The string representation of this object.</returns>
	public override string ToString() => ErrorMessage;
}
