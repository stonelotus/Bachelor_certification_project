import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  final String generatedBy;
  final String title;
  final String description;
  final String location;
  final String date;
  final String time;
  final String? photoUrl;
  final int? ticketCount;
  final int id;

  EventModel({
    required this.id,
    required this.generatedBy,
    required this.title,
    required this.description,
    required this.location,
    required this.date,
    required this.time,
    required this.photoUrl,
    required this.ticketCount,
  });

  Map<String, Object?> toDocument() {
    return {
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
    );
  }
}
