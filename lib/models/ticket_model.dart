import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:licenta_main/main.dart';

class TicketModel {
  final int eventId;
  final int seatNumber;
  final int price;
  late String ticketId;
  final String? eventName;

  TicketModel({
    required this.eventId,
    required this.seatNumber,
    required this.price,
    this.eventName,
  }) {
    this.ticketId = this.eventId.toString() + "_" + this.seatNumber.toString();
  }

  Map<String, Object?> toDocument() {
    return {
      'ticketId': this.ticketId,
      'eventId': eventId,
      'seatNumber': seatNumber,
      'price': price,
      'eventName': eventName,
    };
  }

  factory TicketModel.fromDocument(DocumentSnapshot doc) {
    return TicketModel(
        eventId: doc['eventId'],
        seatNumber: doc['seatNumber'],
        price: doc['price'],
        eventName: doc['eventName']);
  }
}
