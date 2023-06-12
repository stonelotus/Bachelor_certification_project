import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:licenta_main/main.dart';

class TicketModel {
  late String dbId;
  final int blockchainTicketId;

  final String? eventName;
  final int eventId;
  final int seatNumber;
  final double price;
  final int batchNo; // index in a batch (minimum 1)

  TicketModel(
      {required this.eventName,
      required this.eventId,
      required this.seatNumber,
      required this.price,
      required this.batchNo,
      required this.blockchainTicketId}) {
    this.dbId = this.eventId.toString() + "_" + this.seatNumber.toString();
  }

  Map<String, Object?> toDocument() {
    return {
      'dbId': this.dbId,
      'eventName': eventName,
      'eventId': eventId,
      'seatNumber': seatNumber,
      'price': price,
      'batchNo': batchNo,
      'blockchainTicketId': blockchainTicketId
    };
  }

  factory TicketModel.fromDocument(DocumentSnapshot doc) {
    return TicketModel(
        eventName: doc['eventName'],
        eventId: doc['eventId'],
        seatNumber: doc['seatNumber'],
        price: doc['price'],
        batchNo: doc['batchNo'],
        blockchainTicketId: doc['blockchainTicketId']);
  }

  factory TicketModel.empty() {
    return TicketModel(
      eventId: 0,
      seatNumber: 0,
      price: 0,
      batchNo: 0,
      blockchainTicketId: -1,
      eventName: '',
    );
  }
}
