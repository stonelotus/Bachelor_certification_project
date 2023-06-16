import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String id;
  final String email;
  final String displayName;
  final String? photoUrl;
  bool isOrganizer;
  bool isVerified;
  List<dynamic> tickets;

  UserModel(
      {required this.id,
      required this.email,
      required this.displayName,
      this.photoUrl,
      this.tickets = const [],
      this.isOrganizer = false,
      this.isVerified = false});

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
      'tickets': tickets,
      'isOrganizer': isOrganizer,
      'isVerified': isVerified,
    };
  }

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    print("WTF IS THIS");
    print(doc.data());
    return UserModel(
      id: doc['id'],
      email: doc['email'],
      displayName: doc['displayName'],
      photoUrl: doc['photoUrl'],
      tickets: doc['tickets'],
      isOrganizer: doc['isOrganizer'],
      isVerified: doc['isVerified'],
    );
  }

  factory UserModel.empty() {
    return UserModel(
        id: '',
        email: '',
        displayName: '',
        photoUrl: '',
        tickets: [],
        isOrganizer: false,
        isVerified: false);
  }
}
