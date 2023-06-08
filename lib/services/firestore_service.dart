import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:licenta_main/models/event_model.dart';
import 'package:licenta_main/models/ticket_model.dart';
import 'package:licenta_main/models/user_model.dart';
import 'package:licenta_main/pages/events_search_results/events_search_results_widget.dart';

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

  Future<List<TicketModel>> getAllTickets() async {
    final tickets = await _firestore.collection('tickets').get();
    return tickets.docs.map((doc) => TicketModel.fromDocument(doc)).toList();
  }

  Future<EventModel> getEventFromTicket(TicketModel ticket) async {
    var ticketObj = ticket.toDocument();
    final eventObj = await _firestore
        .collection('events')
        .doc(ticketObj['eventId'].toString())
        .get();
    return eventObj.exists
        ? EventModel.fromDocument(eventObj)
        : EventModel.empty();
  }

  Future<List<EventModel>> getAllEvents() async {
    final events = await _firestore.collection('events').get();
    return events.docs.map((doc) => EventModel.fromDocument(doc)).toList();
  }
}
