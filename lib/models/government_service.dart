import 'package:flutter/material.dart';

class GovernmentService {

  const GovernmentService({
    required this.title,
    required this.subtitle,
    required this.icon,
  });
  final String title;
  final String subtitle;
  final IconData icon;
}

// National Government Services
final List<GovernmentService> nationalGovernmentServices = [
  const GovernmentService(
    title: 'National Government Portal',
    subtitle: 'Official government services',
    icon: Icons.account_balance,
  ),
  const GovernmentService(
    title: 'eGovPH',
    subtitle: 'Digital government platform',
    icon: Icons.language,
  ),
  const GovernmentService(
    title: 'PhilSys National ID',
    subtitle: 'Unified identification system',
    icon: Icons.badge,
  ),
  const GovernmentService(
    title: 'BIR',
    subtitle: 'Tax services',
    icon: Icons.receipt_long,
  ),
  const GovernmentService(
    title: 'SSS',
    subtitle: 'Social security',
    icon: Icons.security,
  ),
  const GovernmentService(
    title: 'PhilHealth',
    subtitle: 'Health insurance',
    icon: Icons.local_hospital,
  ),
  const GovernmentService(
    title: 'Pag-IBIG',
    subtitle: 'Housing fund',
    icon: Icons.home,
  ),
  const GovernmentService(
    title: 'LTO',
    subtitle: 'Land transportation',
    icon: Icons.directions_car,
  ),
  const GovernmentService(
    title: 'PSA Civil Registry',
    subtitle: 'Birth, marriage, death records',
    icon: Icons.description,
  ),
  const GovernmentService(
    title: 'DMW',
    subtitle: 'Overseas employment',
    icon: Icons.flight_takeoff,
  ),
  const GovernmentService(
    title: 'DFA Passport',
    subtitle: 'Passport services',
    icon: Icons.book,
  ),
  const GovernmentService(
    title: 'NBI Clearance',
    subtitle: 'Background check',
    icon: Icons.verified_user,
  ),
];

// General Santos City Government Services
final List<GovernmentService> gensanGovernmentServices = [
  const GovernmentService(
    title: "Mayor's Office",
    subtitle: 'City administration',
    icon: Icons.location_city,
  ),
  const GovernmentService(
    title: 'Business Permit & Licensing',
    subtitle: 'Business registration',
    icon: Icons.business,
  ),
  const GovernmentService(
    title: 'City Treasurer',
    subtitle: 'Financial services',
    icon: Icons.account_balance_wallet,
  ),
  const GovernmentService(
    title: "Assessor's Office",
    subtitle: 'Property assessment',
    icon: Icons.assessment,
  ),
  const GovernmentService(
    title: 'Civil Registry',
    subtitle: 'Local civil documents',
    icon: Icons.folder_open,
  ),
  const GovernmentService(
    title: 'Health Office',
    subtitle: 'Public health services',
    icon: Icons.health_and_safety,
  ),
  const GovernmentService(
    title: 'Engineering Office',
    subtitle: 'Infrastructure & engineering',
    icon: Icons.engineering,
  ),
  const GovernmentService(
    title: 'Building Permit',
    subtitle: 'Construction permits',
    icon: Icons.construction,
  ),
  const GovernmentService(
    title: 'Social Welfare',
    subtitle: 'Social services',
    icon: Icons.volunteer_activism,
  ),
  const GovernmentService(
    title: 'Agriculture Office',
    subtitle: 'Agricultural services',
    icon: Icons.agriculture,
  ),
  const GovernmentService(
    title: 'Tourism Office',
    subtitle: 'Tourism & culture',
    icon: Icons.attractions,
  ),
  const GovernmentService(
    title: 'PESO',
    subtitle: 'Public Employment Service',
    icon: Icons.work,
  ),
];
