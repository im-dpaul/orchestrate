import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:orchestrate/core/utils/auth_exception.dart';
import 'package:orchestrate/core/utils/firebase_error_utils.dart';

class TryCatchHandler {
  /// Executes a function and handles exceptions automatically
  static Future<T?> execute<T>({
    required Future<T> Function() function,
    required Function(String errorMessage) onError,
  }) async {
    try {
      return await function();
    } on FirebaseAuthException catch (e) {
      log("🔥 FirebaseAuthException: ${e.code} - ${e.message}");
      onError(FirebaseErrorUtils.getAuthErrorMessage(e.code));

      return null;
    } on FirebaseException catch (e) {
      log("🔥 FirebaseException: ${e.code} - ${e.message}");
      onError(FirebaseErrorUtils.getFirestoreErrorMessage(e.code));

      return null;
    } on AuthException catch (e) {
      log("🔥 Auth Error: ${e.code} - ${e.message}");
      onError(e.message);

      return null;
    } catch (error) {
      log("Unexpected Error: $error");

      onError("Something went wrong. Please try again.");

      return null;
    }
  }
}
