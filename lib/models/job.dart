class Job {

  Job({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.description,
    required this.requirements,
    required this.category,
    required this.salary,
    required this.salaryType,
    required this.postedAt,
    required this.deadline,
    required this.contactEmail,
    required this.contactPhone,
    required this.benefits,
    this.companyLogo,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'],
      title: json['title'],
      company: json['company'],
      location: json['location'],
      description: json['description'],
      requirements: json['requirements'],
      category: json['category'],
      salary: json['salary'],
      salaryType: json['salaryType'],
      postedAt: DateTime.parse(json['postedAt']),
      deadline: DateTime.parse(json['deadline']),
      contactEmail: json['contactEmail'],
      contactPhone: json['contactPhone'],
      benefits: List<String>.from(json['benefits']),
      companyLogo: json['companyLogo'],
    );
  }
  final String id;
  final String title;
  final String company;
  final String location;
  final String description;
  final String requirements;
  final String category;
  final double salary;
  final String salaryType;
  final DateTime postedAt;
  final DateTime deadline;
  final String contactEmail;
  final String contactPhone;
  final List<String> benefits;
  final String? companyLogo;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'company': company,
      'location': location,
      'description': description,
      'requirements': requirements,
      'category': category,
      'salary': salary,
      'salaryType': salaryType,
      'postedAt': postedAt.toIso8601String(),
      'deadline': deadline.toIso8601String(),
      'contactEmail': contactEmail,
      'contactPhone': contactPhone,
      'benefits': benefits,
      'companyLogo': companyLogo,
    };
  }
}