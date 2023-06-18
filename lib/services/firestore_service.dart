import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:licenta_main/models/event_model.dart';
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
        .doc(ticket.dbId)
        .set(ticket.toDocument());
  }

  Future<List<TicketModel>> getAllTickets() async {
    final tickets = await _firestore.collection('tickets').get();
    return tickets.docs.map((doc) => TicketModel.fromDocument(doc)).toList();
  }

  Future<List<TicketModel>> getAllUserTickets(userId) async {
    final user = await getUser(userId);
    final ticketsIds = user.tickets;
    var tickets = <TicketModel>[];
    for (var ticketId in ticketsIds) {
      final ticket = await _firestore.collection('tickets').doc(ticketId).get();
      tickets.add(TicketModel.fromDocument(ticket));
    }
    return tickets;
  }

  Future<TicketModel> getTicketById(ticketId) async {
    final ticket = await _firestore.collection('tickets').doc(ticketId).get();
    return ticket.exists
        ? TicketModel.fromDocument(ticket)
        : TicketModel.empty();
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
        .doc(eventId.toString())
        .get()
        .then((doc) => EventModel.fromDocument(doc));
  }

  Future<void> writeEventToFirestore(EventModel event) async {
    return await _firestore
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

  Future<int> getNumberOfSoldTicketsOfEvent(eventID) async {
    var res = await _firestore
        .collection('tickets')
        .where('eventId', isEqualTo: eventID)
        .count()
        .get();
    return res.count;
  }

  Future<void> addTicketIdToUser(userId, ticket) async {
    final user = await getUser(userId);
    user.tickets.add(ticket.dbId);
    await _firestore.collection('users').doc(userId).set(user.toDocument());
  }

  Future<void> updateEventTicketsAvailable(eventId, ticketsAvailable) async {
    await _firestore
        .collection('events')
        .doc(eventId.toString())
        .update({'ticketsAvailable': ticketsAvailable});
  }

  Future<List<EventModel>> getEventsByOrganizerDisplayName(displayName) async {
    final event = await _firestore
        .collection('events')
        .where('generatedBy', isEqualTo: displayName)
        .get();
    return event.docs.map((doc) => EventModel.fromDocument(doc)).toList();
  }
}
