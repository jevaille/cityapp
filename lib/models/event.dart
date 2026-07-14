class Event {

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.imageUrl,
    required this.startTime,
    required this.endTime,
    required this.category,
    this.latitude,
    this.longitude,
    required this.maxAttendees,
    required this.currentAttendees,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      location: json['location'],
      imageUrl: json['imageUrl'],
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      category: json['category'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      maxAttendees: json['maxAttendees'],
      currentAttendees: json['currentAttendees'],
    );
  }
  final String id;
  final String title;
  final String description;
  final String location;
  final String imageUrl;
  final DateTime startTime;
  final DateTime endTime;
  final String category;
  final double? latitude;
  final double? longitude;
  final int maxAttendees;
  final int currentAttendees;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'location': location,
      'imageUrl': imageUrl,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'category': category,
      'latitude': latitude,
      'longitude': longitude,
      'maxAttendees': maxAttendees,
      'currentAttendees': currentAttendees,
    };
  }
}