import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
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

  Future<UserModel> getUser(userId) async {
    final user = await _firestore.collection('users').doc(userId).get();
    return user.exists ? UserModel.fromDocument(user) : UserModel.empty();
  }

  Future<EventModel> getEventByID(eventId) {
    return _firestore
        .collection('events')
        .doc(eventId)
        .get()
        .then((doc) => EventModel.fromDocument(doc));
  }

  Future<void> writeEventToFirestore(EventModel event) async {
    await _firestore
        .collection('events')
        .doc(event.id.toString())
        .set(event.toDocument());
  }

  Future<EventModel> getUpcomingEvent(userId) async {
    final user = await getUser(userId);
    final ticketsIds = user.tickets;
    var closestEventDateTime = DateTime.now().add(Duration(days: 365));
    var closestEvent = EventModel.empty();
    for (var ticketId in ticketsIds) {
      final ticket = await _firestore.collection('tickets').doc(ticketId).get();
      final ticketObj = ticket.data();
      final event = await _firestore
          .collection('events')
          .doc(ticketObj!['eventId'].toString())
          .get();
      final eventObj = event.data();
      final eventDate = eventObj!['date'];
      final eventTime = eventObj['time'];
      final eventDateTime =
          DateFormat('dd.MM.yyyy HH:mm').parse('$eventDate $eventTime');
      if (eventDateTime.isAfter(DateTime.now()) &&
          eventDateTime.isBefore(closestEventDateTime)) {
        closestEventDateTime = eventDateTime;
        closestEvent = EventModel.fromDocument(event);
      }
    }
    return closestEvent;
  }

  Future<int> getNumberOfEvents() async {
    var res = await _firestore.collection('events').count().get();
    return res.count;
  }
}
