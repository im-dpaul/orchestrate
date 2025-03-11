class FirebaseErrorUtils {
  /// Maps Firebase Authentication error codes to user-friendly messages
  static String getAuthErrorMessage(String code) {
    switch (code) {
      case 'invalid-email':
      case 'auth/invalid-email':
        return "Invalid email format. Please enter a valid email address.";

      case 'user-disabled':
      case 'auth/user-disabled':
        return "This account has been disabled. Please contact support.";

      case 'user-not-found':
      case 'auth/user-not-found':
        return "No account found with this email. Please sign up.";

      case 'wrong-password':
      case 'INVALID_LOGIN_CREDENTIALS':
      case 'invalid-credential':
        return "Invalid credential. Please try again.";

      case 'too-many-requests':
        return "Too many failed attempts. Try again later.";

      case 'user-token-expired':
        return "Session expired. Please log in again.";

      case 'network-request-failed':
        return "No internet connection. Please check your network.";

      case 'email-already-in-use':
        return "This email is already registered. Try logging in.";

      case 'operation-not-allowed':
        return "Email/password login is disabled. Enable it in Firebase Console.";

      case 'weak-password':
        return "Weak password. Use at least 6 characters with a mix of letters and numbers.";

      case 'account-exists-with-different-credential':
        return "An account with this email already exists. Try signing in with a different method.";

      case 'invalid-verification-code':
        return "Invalid OTP code. Please enter the correct verification code.";

      case 'invalid-verification-id':
        return "Invalid verification request. Try again later.";

      case 'auth/missing-android-pkg-name':
        return "An Android package name must be provided for the app.";

      case 'auth/missing-continue-uri':
        return "A continue URL must be provided in the request.";

      case 'auth/missing-ios-bundle-id':
        return "An iOS Bundle ID must be provided if an App Store ID is included.";

      case 'auth/invalid-continue-uri':
        return "The continue URL provided is invalid.";

      case 'auth/unauthorized-continue-uri':
        return "The domain of the continue URL is not whitelisted. Update Firebase settings.";

      default:
        return "An unknown error occurred. Please try again.";
    }
  }

  /// Maps Firestore Errors to User-Friendly Messages
  static String getFirestoreErrorMessage(String code) {
    switch (code) {
      case 'permission-denied':
        return "You don't have permission to access this data.";
      case 'not-found':
        return "Requested document does not exist.";
      case 'already-exists':
        return "This data already exists.";
      case 'unavailable':
        return "Firestore service is temporarily unavailable.";
      case 'cancelled':
        return "Operation was cancelled.";
      case 'data-loss':
        return "Data loss detected. Please try again.";
      default:
        return "An unexpected Firestore error occurred";
    }
  }
}
