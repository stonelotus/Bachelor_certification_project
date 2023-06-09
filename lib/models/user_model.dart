import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String id;
  final String email;
  final String displayName;
  final String? photoUrl;
  List<dynamic> tickets;

  UserModel(
      {required this.id,
      required this.email,
      required this.displayName,
      this.photoUrl,
      this.tickets = const []});

  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      id: user.uid,
      email: user.email ?? '',
      displayName: user.displayName ?? '',
      photoUrl: user.photoURL,
    );
  }

  Map<String, Object?> toDocument() {
    return {
      'id': id,
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'tickets': tickets
    };
  }

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    return UserModel(
      id: doc['id'],
      email: doc['email'],
      displayName: doc['displayName'],
      photoUrl: doc['photoUrl'],
      tickets: doc['tickets'],
    );
  }

  factory UserModel.empty() {
    return UserModel(
      id: '',
      email: '',
      displayName: '',
      photoUrl: '',
      tickets: [],
    );
  }
}
