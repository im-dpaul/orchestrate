import 'package:firebase_auth/firebase_auth.dart';
import 'package:orchestrate/core/utils/try_catch_handler.dart';

class FirebaseAuthService {
  static final FirebaseAuthService _instance = FirebaseAuthService._internal();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseAuthService._internal();
  factory FirebaseAuthService() {
    return _instance;
  }

  /// Get current user
  User? get currentUser => _auth.currentUser;

  /// Sign Up with Email & Password
  Future<User?> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    return await TryCatchHandler.execute<User?>(
      function: () async {
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        return userCredential.user;
      },
      onError: (errorMessage) {
        throw errorMessage;
      },
    );
  }

  /// Sign In with Email & Password
  Future<User?> signInWithEmail({
    required String email,
    required String password,
  }) async {
    return await TryCatchHandler.execute<User?>(
      function: () async {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        return userCredential.user;
      },
      onError: (errorMessage) {
        throw errorMessage;
      },
    );
  }

  /// Sign Out
  Future<void> signOut() async {
    return await TryCatchHandler.execute<void>(
      function: () async {
        await _auth.signOut();
      },
      onError: (errorMessage) {
        throw errorMessage;
      },
    );
  }

  /// Send Password Reset Email
  Future<void> sendPasswordResetEmail(String email) async {
    return await TryCatchHandler.execute<void>(
      function: () async {
        await _auth.sendPasswordResetEmail(email: email);
      },
      onError: (errorMessage) {
        throw errorMessage;
      },
    );
  }

  /// Phone Number Authentication - Request OTP
  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    required void Function(String, int?) codeSent,
    required void Function(FirebaseAuthException) verificationFailed,
    required void Function(PhoneAuthCredential) verificationCompleted,
  }) async {
    return await TryCatchHandler.execute<void>(
      function: () async {
        await _auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) async {
            verificationCompleted(credential);
          },
          verificationFailed: (FirebaseAuthException e) {
            verificationFailed(e);
          },
          codeSent: (String verificationId, int? resendToken) {
            codeSent(verificationId, resendToken);
          },
          codeAutoRetrievalTimeout: (String verificationId) {},
        );
      },
      onError: (errorMessage) {
        throw errorMessage;
      },
    );
  }

  /// Phone Number Authentication - Verify OTP
  Future<User?> verifyOtp({
    required String verificationId,
    required String otp,
  }) async {
    return await TryCatchHandler.execute<User?>(
      function: () async {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId,
          smsCode: otp,
        );
        UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        return userCredential.user;
      },
      onError: (errorMessage) {
        throw errorMessage;
      },
    );
  }
}
