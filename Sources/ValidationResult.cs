namespace Belin.Validation;

/// <summary>
/// The result of running a validator.
/// </summary>
public class ValidationResult {

	/// <summary>
	/// The list of errors that occurred.
	/// </summary>
	public IList<ValidationFailure> Errors { get; set; } = [];

	/// <summary>
	/// Value indicating whether the validation succeeded.
	/// </summary>
	public bool IsValid => Errors.Count == 0;

	/// <summary>
	/// Returns a string representation of this object.
	/// </summary>
	/// <returns>The string representation of this object.</returns>
	public override string ToString() => ToString(Environment.NewLine);

	/// <summary>
	/// Returns a string representation of this object.
	/// </summary>
	/// <param name="separator">The string used to separate the error messages.</param>
	/// <returns>The string representation of this object.</returns>
	public string ToString(string separator) => string.Join(separator, Errors.Select(error => error.ToString()));
}
