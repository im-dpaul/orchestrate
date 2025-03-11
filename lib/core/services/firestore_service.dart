import 'package:cloud_firestore/cloud_firestore.dart';

/// Singleton Firestore Service (ONE instance for the entire app)
class FirestoreService {
  static final FirestoreService _instance = FirestoreService._internal();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  FirestoreService._internal();

  factory FirestoreService() {
    return _instance;
  }

  FirebaseFirestore get instance => _firestore;
}
