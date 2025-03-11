import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orchestrate/core/constants/app_enums.dart';
import 'package:orchestrate/core/constants/app_extensions.dart';
import 'package:orchestrate/core/models/user_model.dart';
import 'package:orchestrate/core/services/firebase_auth_service.dart';
import 'package:orchestrate/core/services/user_service.dart';

class SplashProvider with ChangeNotifier {
  User? _getCurrentUser() {
    try {
      User? user = FirebaseAuthService().currentUser;

      if (user != null) {
        log("User: $user");
        return user;
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  Future<bool?> _getUserRole({required String userId}) async {
    UserModel? user = await UserService().getUserById(userId: userId);

    if ((user?.email ?? "").isNotEmpty) {
      return user?.isAdmin ?? false;
    }
    return null;
  }

  Future<String> checkUserRole() async {
    String role = "";

    User? user = _getCurrentUser();
    if (user == null) {
      return role;
    } else {
      bool? isAdmin = await _getUserRole(userId: user.uid);
      if (isAdmin == null) {
        return role;
      } else {
        role = isAdmin ? UserType.admin.value : UserType.user.value;
      }
    }

    return role;
  }
}
