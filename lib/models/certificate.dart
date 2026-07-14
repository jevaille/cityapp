class Certificate {

  Certificate({
    required this.id,
    required this.type,
    required this.fullName,
    this.spouseName,
    required this.dateOfBirth,
    required this.placeOfBirth,
    this.parents,
    required this.issueDate,
    required this.certificateNumber,
    required this.status,
    required this.userId,
  });

  factory Certificate.fromJson(Map<String, dynamic> json) {
    return Certificate(
      id: json['id'],
      type: json['type'],
      fullName: json['fullName'],
      spouseName: json['spouseName'],
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
      placeOfBirth: json['placeOfBirth'],
      parents: json['parents'],
      issueDate: DateTime.parse(json['issueDate']),
      certificateNumber: json['certificateNumber'],
      status: json['status'],
      userId: json['userId'],
    );
  }
  final String id;
  final String type;
  final String fullName;
  final String? spouseName;
  final DateTime dateOfBirth;
  final String placeOfBirth;
  final String? parents;
  final DateTime issueDate;
  final String certificateNumber;
  final String status;
  final String userId;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'fullName': fullName,
      'spouseName': spouseName,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'placeOfBirth': placeOfBirth,
      'parents': parents,
      'issueDate': issueDate.toIso8601String(),
      'certificateNumber': certificateNumber,
      'status': status,
      'userId': userId,
    };
  }
}