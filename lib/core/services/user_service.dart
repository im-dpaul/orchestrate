import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:orchestrate/core/constants/app_constants.dart';
import 'package:orchestrate/core/models/user_model.dart';
import 'package:orchestrate/core/services/firestore_service.dart';
import 'package:orchestrate/core/utils/try_catch_handler.dart';

class UserService {
  final FirebaseFirestore _firestore = FirestoreService().instance;
  final String collectionPath = Constants.usersCollectionPath;

  /// Create User
  Future<void> createUser({required UserModel user}) async {
    Map<String, dynamic> userMap = user.toMap();
    userMap['createdAt'] = FieldValue.serverTimestamp();
    userMap['updatedAt'] = FieldValue.serverTimestamp();

    await TryCatchHandler.execute(
      function: () async {
        await _firestore
            .collection(collectionPath)
            .doc(user.userId)
            .set(userMap);
      },
      onError: (errorMessage) => throw errorMessage,
    );
  }

  /// Get User by ID
  Future<UserModel?> getUserById({required String userId}) async {
    return await TryCatchHandler.execute<UserModel?>(
      function: () async {
        DocumentSnapshot doc =
            await _firestore.collection(collectionPath).doc(userId).get();
        if (doc.exists) {
          return UserModel.fromMap(doc.data() as Map<String, dynamic>);
        }
        return null;
      },
      onError: (errorMessage) => throw errorMessage,
    );
  }

  /// Get All Users (Stream for Real-Time Updates)
  Stream<List<UserModel>> getUsers() {
    return _firestore.collection(collectionPath).snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => UserModel.fromMap(doc.data()))
              .toList(),
        );
  }

  /// Update User
  Future<void> updateUser(
      {required String userId,
      required Map<String, dynamic> updatedData}) async {
    updatedData['updatedAt'] = FieldValue.serverTimestamp();

    await TryCatchHandler.execute(
      function: () async {
        await _firestore
            .collection(collectionPath)
            .doc(userId)
            .update(updatedData);
      },
      onError: (errorMessage) => throw errorMessage,
    );
  }

  /// Delete User
  Future<void> deleteUser({required String userId}) async {
    await TryCatchHandler.execute(
      function: () async {
        await _firestore.collection(collectionPath).doc(userId).delete();
      },
      onError: (errorMessage) => throw errorMessage,
    );
  }
}
