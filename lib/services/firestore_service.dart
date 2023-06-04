import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:licenta_main/models/user_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveUserToFirestore(UserModel user) async {
    await _firestore.collection('users').doc(user.id).set(user.toDocument());
  }
}
