class Report {

  Report({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.status,
    required this.location,
    this.latitude,
    this.longitude,
    required this.images,
    required this.reportedAt,
    required this.reporterId,
    this.assignedTo,
    required this.updates,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      status: json['status'],
      location: json['location'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      images: List<String>.from(json['images']),
      reportedAt: DateTime.parse(json['reportedAt']),
      reporterId: json['reporterId'],
      assignedTo: json['assignedTo'],
      updates: List<String>.from(json['updates']),
    );
  }
  final String id;
  final String title;
  final String description;
  final String category;
  final String status;
  final String location;
  final double? latitude;
  final double? longitude;
  final List<String> images;
  final DateTime reportedAt;
  final String reporterId;
  final String? assignedTo;
  final List<String> updates;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'status': status,
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
      'images': images,
      'reportedAt': reportedAt.toIso8601String(),
      'reporterId': reporterId,
      'assignedTo': assignedTo,
      'updates': updates,
    };
  }
}