class InputValidators {
  /// Email Validation
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  /// Validates a 10-digit mobile number (Only numbers allowed)
  static bool isValidMobileNumber(String number) {
    final RegExp mobileRegex = RegExp(r'^[0-9]{10}$');
    return mobileRegex.hasMatch(number);
  }

  /// Validates a 6-digit OTP (Only numbers allowed)
  static bool isValidOtp(String otp) {
    final RegExp otpRegex = RegExp(r'^[0-9]{6}$');
    return otpRegex.hasMatch(otp);
  }

  /// Name Validation (Allows only letters, spaces, and min 2 chars)
  static bool isValidName(String name) {
    final nameRegex = RegExp(r'^[a-zA-Z ]{2,}$');
    return nameRegex.hasMatch(name);
  }

  /// Password Validation (Minimum 6 characters)
  static bool isValidPassword(String password) {
    return password.length >= 6;
  }
}
