class Permit {

  Permit({
    required this.id,
    required this.businessName,
    required this.type,
    required this.status,
    required this.address,
    required this.contactPhone,
    required this.contactEmail,
    required this.applicationDate,
    this.expiryDate,
    this.permitNumber,
    this.documents,
  });

  factory Permit.fromJson(Map<String, dynamic> json) {
    return Permit(
      id: json['id'],
      businessName: json['businessName'],
      type: json['type'],
      status: json['status'],
      address: json['address'],
      contactPhone: json['contactPhone'],
      contactEmail: json['contactEmail'],
      applicationDate: DateTime.parse(json['applicationDate']),
      expiryDate: json['expiryDate'] != null
          ? DateTime.parse(json['expiryDate'])
          : null,
      permitNumber: json['permitNumber'],
      documents: json['documents'],
    );
  }
  final String id;
  final String businessName;
  final String type;
  final String status;
  final String address;
  final String contactPhone;
  final String contactEmail;
  final DateTime applicationDate;
  final DateTime? expiryDate;
  final String? permitNumber;
  final String? documents;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'businessName': businessName,
      'type': type,
      'status': status,
      'address': address,
      'contactPhone': contactPhone,
      'contactEmail': contactEmail,
      'applicationDate': applicationDate.toIso8601String(),
      'expiryDate': expiryDate?.toIso8601String(),
      'permitNumber': permitNumber,
      'documents': documents,
    };
  }
}