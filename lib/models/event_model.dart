class EventModel {
  final String generatedBy;
  final String title;
  final String description;
  final String location;
  final String date;
  final String time;
  final String? photoUrl;
  final int? ticketCount;

  EventModel({
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
}
