import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orchestrate/core/constants/strings.dart';
import 'package:orchestrate/core/models/user_model.dart';
import 'package:orchestrate/core/services/user_service.dart';
import 'package:orchestrate/core/utils/input_validators.dart';
import 'package:orchestrate/features/authentication/repository/auth_repository.dart';

class LoginProvider with ChangeNotifier {
  bool isLoading = false;
  final AuthRepository _authRepository = AuthRepository();

  // ------------------------ Signin Screen ------------------------

  bool showPassword = true;
  bool isAdmin = false;

  String? emailErrorText;
  String? passwordErrorText;
  String? authErrorText;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // ------------------------ Forgot Password Screen ------------------------

  String? resetEmailErrorText;

  TextEditingController resetEmailController = TextEditingController();

  // ------------------------ Signin Screen ------------------------

  void togglePasswordVisibility() {
    showPassword = !showPassword;
    notifyListeners();
  }

  void updateEmailErrorText({String? message}) {
    emailErrorText = message;
    notifyListeners();
  }

  void updatePasswordErrorText({String? message}) {
    passwordErrorText = message;
    notifyListeners();
  }

  void updateAuthErrorText({String? message}) {
    authErrorText = message;
    notifyListeners();
  }

  Future<bool> _getUserRole({required String userId}) async {
    UserModel? user = await UserService().getUserById(userId: userId);

    if ((user?.email ?? "").isNotEmpty) {
      return user?.isAdmin ?? false;
    }
    return false;
  }

  Future<bool> onLoginButtonTap() async {
    isLoading = true;
    notifyListeners();

    bool userLoggedIn = false;
    final String email = emailController.text;
    final String password = passwordController.text;

    // Reset error messages before validation
    updateEmailErrorText(message: null);
    updatePasswordErrorText(message: null);
    updateAuthErrorText(message: null);

    // Validate input fields
    bool validEmail = InputValidators.isValidEmail(email);
    bool validPassword = password.isNotEmpty;

    if (!validEmail) {
      updateEmailErrorText(message: Strings.invalidEmail);
    }
    if (!validPassword) {
      updatePasswordErrorText(message: Strings.invalidPassword);
    }

    if (!validEmail || !validPassword) {
      isLoading = false;
      notifyListeners();
      return false;
    }

    try {
      User? user =
          await _authRepository.loginUser(email: email, password: password);
      if ((user?.email ?? "").isNotEmpty) {
        userLoggedIn = true;
        isAdmin = await _getUserRole(userId: user?.uid ?? "");
      }
    } catch (error) {
      updateAuthErrorText(message: error.toString());
    }

    isLoading = false;
    notifyListeners();
    return userLoggedIn;
  }

  // ------------------------ Forgot Password Screen ------------------------

  void updateResetEmailErrorText({String? message}) {
    resetEmailErrorText = message;
    notifyListeners();
  }

  Future<bool> onSubmitTap() async {
    bool emailSent = false;
    isLoading = true;
    notifyListeners();
    final String email = resetEmailController.text;

    updateResetEmailErrorText(message: null);
    bool validEmail = InputValidators.isValidEmail(email);

    try {
      if (!validEmail) {
        updateResetEmailErrorText(message: Strings.invalidEmail);
      } else {
        await _authRepository.sendResetPasswordLink(email: email);
        emailSent = true;
      }
    } catch (e) {
      updateResetEmailErrorText(message: e.toString());
    }

    isLoading = false;
    notifyListeners();
    return emailSent;
  }
}
