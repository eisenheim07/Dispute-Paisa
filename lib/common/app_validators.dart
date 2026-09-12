/// Central validators for the entire application.
/// Use ONLY these validators for any field validation across all screens.
abstract final class AppValidators {
  AppValidators._();

  // ─────────────────────────────────────────────────────────────
  // PHONE
  // ─────────────────────────────────────────────────────────────

  /// Validates a 10-digit Indian mobile number.
  /// Returns an error string or `null` if valid.
  static String? phone(String? value) {
    if (value == null || value.isEmpty) return 'Mobile number is required';
    if (value.length != 10) return 'Enter a valid 10-digit mobile number';
    if (!RegExp(r'^[6-9]\d{9}$').hasMatch(value)) {
      return 'Enter a valid Indian mobile number';
    }
    return null;
  }

  // ─────────────────────────────────────────────────────────────
  // EMAIL  (reserved for future screens)
  // ─────────────────────────────────────────────────────────────

  /// Validates an email address.
  static String? email(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    if (!RegExp(r'^[\w.+-]+@[\w-]+\.[a-zA-Z]{2,}$').hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  // ─────────────────────────────────────────────────────────────
  // REQUIRED — generic non-empty check
  // ─────────────────────────────────────────────────────────────

  /// Returns error if [value] is null or blank.
  static String? required(String? value, {String message = 'This field is required'}) {
    if (value == null || value.trim().isEmpty) return message;
    return null;
  }
}
