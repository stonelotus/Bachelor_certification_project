import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  final String generatedBy;
  final String title;
  final String description;
  final String location;
  final String date;
  final String time;
  final String? photoUrl;
  final int ticketCount;
  final int id;
  final double ticketPrice;

  EventModel(
      {required this.id,
      required this.generatedBy,
      required this.title,
      required this.description,
      required this.location,
      required this.date,
      required this.time,
      required this.photoUrl,
      required this.ticketCount,
      required this.ticketPrice});

  Map<String, Object?> toDocument() {
    return {
      'id': id,
      'generatedBy': generatedBy,
      'title': title,
      'description': description,
      'location': location,
      'date': date,
      'time': time,
      'photoUrl': photoUrl,
      'ticketCount': ticketCount,
    };
  }

  factory EventModel.fromDocument(DocumentSnapshot doc) {
    return EventModel(
      id: doc['id'],
      generatedBy: doc['generatedBy'],
      title: doc['title'],
      description: doc['description'],
      location: doc['location'],
      date: doc['date'],
      time: doc['time'],
      photoUrl: doc['photoUrl'],
      ticketCount: doc['ticketCount'],
      ticketPrice: double.parse(doc['ticketPrice'].toString()),
    );
  }
  factory EventModel.empty() {
    return EventModel(
      id: 0,
      generatedBy: '',
      title: '',
      description: '',
      location: '',
      date: '',
      time: '',
      photoUrl: '',
      ticketCount: 0,
      ticketPrice: 0.0,
    );
  }

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
        id: json['id'] as int,
        generatedBy: json['generatedBy'] as String,
        title: json['title'] as String,
        description: json['description'] as String,
        location: json['location'] as String,
        date: json['date']
            as String, // or use DateTime.parse(json['date']) if the date is a string
        time: json['time']
            as String, // or use DateTime.parse(json['time']) if the time is a string
        photoUrl: json['photoUrl'] as String,
        ticketCount: json['ticketCount'] as int,
        ticketPrice:
            json['ticketPrice'] as double // make sure ticketCount is an int
        );
  }
}
