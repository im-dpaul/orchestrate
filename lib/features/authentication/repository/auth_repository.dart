import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:orchestrate/core/services/firebase_auth_service.dart';

class AuthRepository {
  Future<User?> loginUser(
      {required String email, required String password}) async {
    try {
      User? user = await FirebaseAuthService()
          .signInWithEmail(email: email, password: password);

      log("User Logged In: ${user?.email}");
      return user;
    } catch (e) {
      log("Login Failed: $e");
      rethrow;
    }
  }

  Future<User?> registerUser(
      {required String email, required String password}) async {
    try {
      User? user = await FirebaseAuthService()
          .signUpWithEmail(email: email, password: password);

      log("User Registered: ${user?.email}");
      return user;
    } catch (e) {
      log("Sign Up Failed: $e");
      rethrow;
    }
  }

  Future<void> sendResetPasswordLink({required String email}) async {
    try {
      await FirebaseAuthService().sendPasswordResetEmail(email);
    } catch (e) {
      log("Password Reset Failed: $e");
      rethrow;
    }
  }

  Future<void> requestOtp({
    required String phoneNumber,
    required void Function(String) codeSent,
    required void Function(FirebaseAuthException) verificationFailed,
    required void Function(PhoneAuthCredential) verificationCompleted,
  }) async {
    try {
      await FirebaseAuthService().verifyPhoneNumber(
        phoneNumber: phoneNumber,
        codeSent: (String verificationId, int? resendToken) {
          log("OTP Sent. Verification ID: $verificationId");
          codeSent(verificationId);
        },
        verificationCompleted: (PhoneAuthCredential credential) {
          log("OTP Verification Credential: $credential");
          verificationCompleted(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          log("OTP Verification Failed: ${e.message}");
          verificationFailed(e);
        },
      );
    } catch (e) {
      log("Phone Verification Failed: $e");
      rethrow;
    }
  }

  Future<User?> verifyOtp(
      {required String verificationId, required String otp}) async {
    try {
      User? user = await FirebaseAuthService().verifyOtp(
        verificationId: verificationId,
        otp: otp,
      );
      if (user != null) {
        log("Phone Verification Successful. User: ${user.phoneNumber}");
      }
      return user;
    } catch (e) {
      log("OTP Verification Failed: $e");
      rethrow;
    }
  }

  Future<void> logoutUser() async {
    try {
      await FirebaseAuthService().signOut();
      log("User Logged Out");
    } catch (e) {
      log("Sign Out Failed: $e");
      rethrow;
    }
  }
}
