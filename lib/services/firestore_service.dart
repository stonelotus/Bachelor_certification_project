import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:licenta_main/models/ticket_model.dart';
import 'package:licenta_main/models/user_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveUserToFirestore(UserModel user) async {
    await _firestore.collection('users').doc(user.id).set(user.toDocument());
  }

  Future<void> writeTicketToFirestore(TicketModel ticket) async {
    await _firestore
        .collection('tickets')
        .doc(ticket.ticketId)
        .set(ticket.toDocument());
  }
}
