import 'dart:ffi';

class TicketModel {
  final int eventId;
  final int seatNumber;
  final int price;
  late String ticketId;

  TicketModel({
    required this.eventId,
    required this.seatNumber,
    required this.price,
  }) {
    this.ticketId = this.eventId.toString() + "_" + this.seatNumber.toString();
  }

  Map<String, Object?> toDocument() {
    return {
      'ticketId': this.ticketId,
      'eventId': eventId,
      'seatNumber': seatNumber,
      'price': price,
    };
  }
}
