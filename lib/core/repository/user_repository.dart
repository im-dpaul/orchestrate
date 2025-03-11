import 'dart:developer';

import 'package:orchestrate/core/models/user_model.dart';
import 'package:orchestrate/core/services/user_service.dart';

class UserRepository {
  final UserService _userService = UserService();

  /// Create User
  Future<void> createUser(UserModel user) async {
    try {
      await _userService.createUser(user: user);
    } catch (e) {
      log("User Creation Failed: $e");
      rethrow;
    }
  }

  /// Get User by ID
  Future<UserModel?> getUserById(String userId) async {
    try {
      UserModel? user = await _userService.getUserById(userId: userId);
      if ((user?.userId ?? "").isNotEmpty) {
        log("User: $user");
      }

      return user;
    } catch (e) {
      log("Failed to fetch User data: $e");
      rethrow;
    }
  }
}
