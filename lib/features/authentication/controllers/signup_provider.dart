import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orchestrate/core/constants/app_enums.dart';
import 'package:orchestrate/core/constants/strings.dart';
import 'package:orchestrate/core/models/user_model.dart';
import 'package:orchestrate/core/repository/user_repository.dart';
import 'package:orchestrate/core/utils/firebase_error_utils.dart';
import 'package:orchestrate/core/utils/input_validators.dart';
import 'package:orchestrate/features/authentication/repository/auth_repository.dart';

class SignupProvider with ChangeNotifier {
  bool isLoading = false;
  bool isRegisterUser = true;

  User? registerdUser;

  final AuthRepository _authRepository = AuthRepository();
  final UserRepository _userRepository = UserRepository();

  // ------------------------ Signup Screen ------------------------

  String? emailErrorText;
  String? nameErrorText;
  String? phoneErrorText;

  TextEditingController nameController = TextEditingController();
  TextEditingController newEmailController = TextEditingController();
  TextEditingController newMobileController = TextEditingController();

  // ------------------------ Create-Reset Password Screen ------------------------

  bool isCreatePassword = true;
  bool showNewPassword = true;
  bool showConfirmPassword = true;

  String? newPasswordErrorText;
  String? confirmPasswordErrorText;
  String? submitPasswordErrorText;

  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  // ------------------------ OTP Screen ------------------------

  String? otpErrorText;
  String? otpVerifyErrorText;
  String _verificationId = "";

  int timerSecond = 45;
  Timer otpTimer = Timer(const Duration(seconds: 0), () {});

  TextEditingController otpController = TextEditingController();

  // ------------------------ Role Selection Screen ------------------------

  String? finishErrorText;

  UserType userType = UserType.user;

  // ------------------------ Signup Screen ------------------------

  void updateEmailErrorText({String? message}) {
    emailErrorText = message;
    notifyListeners();
  }

  void updateNameErrorText({String? message}) {
    nameErrorText = message;
    notifyListeners();
  }

  void updatePhoneErrorText({String? message}) {
    phoneErrorText = message;
    notifyListeners();
  }

  bool _validateFields() {
    bool validated = true;

    final String name = nameController.text;
    final String email = newEmailController.text;
    final String mobile = newMobileController.text;

    // Reset error messages before validation
    updateEmailErrorText(message: null);
    updateNameErrorText(message: null);
    updatePhoneErrorText(message: null);

    // Validate input fields
    bool validEmail = InputValidators.isValidEmail(email);
    bool validName = InputValidators.isValidName(name);
    bool validPhone = InputValidators.isValidMobileNumber(mobile);

    if (!validEmail) {
      updateEmailErrorText(message: Strings.invalidEmail);
    }
    if (!validName) {
      updateNameErrorText(message: Strings.invalidName);
    }
    if (!validPhone) {
      updatePhoneErrorText(message: Strings.invalidMobile);
    }

    if (!validEmail || !validName || !validPhone) {
      validated = false;
    }

    return validated;
  }

  bool onContinueButtonTap() {
    isLoading = true;
    notifyListeners();

    bool fieldsValidated = _validateFields();

    isLoading = false;
    notifyListeners();

    return fieldsValidated;
  }

  // ------------------------ Create-Reset Password Screen ------------------------

  void toggleNewPasswordVisibility() {
    showNewPassword = !showNewPassword;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    showConfirmPassword = !showConfirmPassword;
    notifyListeners();
  }

  void updateNewPasswordErrorText({String? message}) {
    newPasswordErrorText = message;
    notifyListeners();
  }

  void updateConfirmPasswordErrorText({String? message}) {
    confirmPasswordErrorText = message;
    notifyListeners();
  }

  void updateSubmitPasswordErrorText({String? message}) {
    submitPasswordErrorText = message;
    notifyListeners();
  }

  bool _validatePasswordFields() {
    bool validated = true;

    final String password = newPasswordController.text;
    final String confirmPassword = confirmPasswordController.text;

    // Reset error messages before validation
    updateNewPasswordErrorText(message: null);
    updateConfirmPasswordErrorText(message: null);

    // Validate input fields
    bool isValidPassword = InputValidators.isValidPassword(password);
    bool isValidConfirmPassword = password == confirmPassword;

    if (!isValidPassword) {
      updateNewPasswordErrorText(message: Strings.invalidPassword);
    }
    if (!isValidConfirmPassword) {
      updateConfirmPasswordErrorText(message: Strings.invalidConfirmPassword);
    }
    if (!isValidPassword || !isValidConfirmPassword) {
      validated = false;
    }

    return validated;
  }

  Future<bool> _addUser() async {
    final String userId = registerdUser?.uid ?? "";
    final String name = nameController.text;
    final String email = registerdUser?.email ?? "";
    final String phoneNumber = newMobileController.text;
    final bool isAdmin = userType == UserType.admin;

    UserModel user = UserModel(
      userId: userId,
      name: name,
      phoneNumber: phoneNumber,
      email: email,
      isAdmin: isAdmin,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    try {
      await _userRepository.createUser(user);
      return true;
    } catch (e) {
      updateFinishErrorText(message: e.toString());
    }
    return false;
  }

  Future<bool> onSubmitPasswordTap() async {
    isLoading = true;
    notifyListeners();

    bool registered = false;
    bool validated = _validatePasswordFields();

    try {
      if (validated) {
        final String email = newEmailController.text;
        final String password = newPasswordController.text;

        User? user = await _authRepository.registerUser(
            email: email, password: password);

        if ((user?.uid ?? "").isNotEmpty) {
          registered = true;
          log("User: $user");
          registerdUser = user;
        }
      }
    } catch (e) {
      updateSubmitPasswordErrorText(message: e.toString());
    }

    bool userCreated = false;
    if (registered) {
      userCreated = await _addUser();
    }

    isLoading = false;
    notifyListeners();
    return registered && userCreated;
  }

  // ------------------------ OTP Screen ------------------------

  void updateOTPErrorText({String? message}) {
    otpErrorText = message;
    notifyListeners();
  }

  void updateOTPVerifyErrorText({String? message}) {
    otpVerifyErrorText = message;
    notifyListeners();
  }

  /// Start timer & send OTP
  Future<void> startTimer() async {
    timerSecond = 45;
    final String mobile = "+91${newMobileController.text}";

    try {
      await _authRepository.requestOtp(
          phoneNumber: mobile,
          codeSent: (String verificationId) {
            _verificationId = verificationId;
          },
          verificationCompleted: (C) {},
          verificationFailed: (error) {
            _onVerificationFailed(error);
          });

      otpTimer = Timer.periodic(const Duration(seconds: 1), (Timer tick) {
        timerSecond = timerSecond > 0 ? timerSecond - 1 : 0;
        notifyListeners();
        if (timerSecond == 0) {
          otpTimer.cancel();
        }
      });
    } catch (e) {
      updateOTPErrorText(message: e.toString());
    }
  }

  void _onVerificationFailed(FirebaseAuthException error) {
    String msg = FirebaseErrorUtils.getAuthErrorMessage(error.code);
    updateOTPVerifyErrorText(message: msg);
  }

  Future<bool> onOTPVerifyButtonTap() async {
    isLoading = true;
    notifyListeners();

    bool verified = false;
    String otp = otpController.text;
    if (!InputValidators.isValidOtp(otp)) {
      updateOTPErrorText(message: Strings.invalidOTP);
      isLoading = false;
      notifyListeners();
      return verified;
    }

    try {
      User? user = await _authRepository.verifyOtp(
          verificationId: _verificationId, otp: otp);
      if ((user?.phoneNumber ?? "").isNotEmpty) {
        verified = true;
      }
    } catch (e) {
      updateOTPErrorText(message: e.toString());
    }

    isLoading = false;
    notifyListeners();
    return verified;
  }

  // ------------------------ Role Selection Screen ------------------------

  void updateFinishErrorText({String? message}) {
    finishErrorText = message;
    notifyListeners();
  }

  void setUserType(UserType role) {
    userType = role;
    notifyListeners();
  }

  Future<void> onFinishTap() async {
    isLoading = true;
    notifyListeners();

    isLoading = false;
    notifyListeners();
  }
}
