import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../app/theme.dart';

class DirectoryPage extends StatelessWidget {
  DirectoryPage({super.key});

  final List<Map<String, dynamic>> _offices = [
    {
      'id': '1',
      'name': 'City Mayor\'s Office',
      'location': 'Left wing, Ground Level',
      'contact': '+63 83 554-4214',
      'email': 'citymayor@gensantos.gov.ph',
      'icon': Icons.account_balance_rounded,
      'color': Colors.blue,
    },
    {
      'id': '2',
      'name': 'City Vice Mayor\'s Office',
      'location': 'City Hall',
      'contact': 'N/A',
      'icon': Icons.account_balance_rounded,
      'color': Colors.blue,
    },
    {
      'id': '3',
      'name': 'Sangguniang Panlungsod',
      'location': 'City Hall',
      'contact': '+63 83 554-3512',
      'icon': Icons.gavel_rounded,
      'color': Colors.purple,
    },
    {
      'id': '4',
      'name': 'City Administrator\'s Office',
      'location': 'City Hall',
      'contact': '+63 83 552-2720',
      'icon': Icons.admin_panel_settings_rounded,
      'color': Colors.teal,
    },
    {
      'id': '5',
      'name': 'Human Resource Management Office',
      'location': 'City Hall',
      'contact': '+63 83 553-9109',
      'icon': Icons.people_rounded,
      'color': Colors.orange,
    },
    {
      'id': '6',
      'name': 'City Planning and Development Office',
      'location': 'City Hall',
      'contact': '+63 83 553-9034',
      'icon': Icons.architecture_rounded,
      'color': Colors.green,
    },
    {
      'id': '7',
      'name': 'Local Civil Registrar\'s Office',
      'location': 'City Hall',
      'contact': '+63 83 552-8665',
      'icon': Icons.description_rounded,
      'color': Colors.blue,
    },
    {
      'id': '8',
      'name': 'City Budget Office',
      'location': 'City Hall',
      'contact': '+63 83 553-7996',
      'icon': Icons.attach_money_rounded,
      'color': Colors.green,
    },
    {
      'id': '9',
      'name': 'City Accountant\'s Office',
      'location': 'City Hall',
      'contact': '+63 83 553-9138',
      'icon': Icons.calculate_rounded,
      'color': Colors.indigo,
    },
    {
      'id': '10',
      'name': 'City Treasurer\'s Office',
      'location': 'City Hall',
      'contact': '+63 83 554-5453',
      'icon': Icons.credit_card_rounded,
      'color': Colors.green,
    },
    {
      'id': '11',
      'name': 'City Assessor\'s Office',
      'location': 'City Hall',
      'contact': '+63 83 553-6369',
      'icon': Icons.assessment_rounded,
      'color': Colors.blue,
    },
    {
      'id': '12',
      'name': 'City Legal Office',
      'location': 'City Hall',
      'contact': '+63 83 552-9159',
      'icon': Icons.gavel_rounded,
      'color': Colors.purple,
    },
    {
      'id': '13',
      'name': 'City General Services Office',
      'location': 'City Hall',
      'contact': '+63 83 552-2509',
      'icon': Icons.build_rounded,
      'color': Colors.orange,
    },
    {
      'id': '14',
      'name': 'City Internal Audit Services',
      'location': 'City Hall',
      'contact': 'N/A',
      'icon': Icons.verified_rounded,
      'color': Colors.teal,
    },
    {
      'id': '15',
      'name': 'City Health Services Office',
      'location': 'City Hall',
      'contact': '+63 83 302-3922',
      'icon': Icons.health_and_safety_rounded,
      'color': Colors.red,
    },
    {
      'id': '16',
      'name': 'City Social Welfare Office',
      'location': 'City Hall',
      'contact': '+63 83 553-4949',
      'icon': Icons.favorite_rounded,
      'color': Colors.pink,
    },
    {
      'id': '17',
      'name': 'City Population Management Office',
      'location': 'City Hall',
      'contact': '+63 83 302-3947',
      'icon': Icons.people_rounded,
      'color': Colors.blue,
    },
    {
      'id': '18',
      'name': 'City Agriculturist\'s Office',
      'location': 'City Hall',
      'contact': '+63 83 553-8643',
      'icon': Icons.grass_rounded,
      'color': Colors.green,
    },
    {
      'id': '19',
      'name': 'City Veterinarian\'s Office',
      'location': 'City Hall',
      'contact': '+63 83 552-1135',
      'icon': Icons.pets_rounded,
      'color': Colors.brown,
    },
    {
      'id': '20',
      'name': 'City Environment Office',
      'location': 'City Hall',
      'contact': 'N/A',
      'icon': Icons.nature_rounded,
      'color': Colors.green,
    },
    {
      'id': '21',
      'name': 'City Engineer\'s Office',
      'location': 'City Hall',
      'contact': '+63 83 552-4234',
      'icon': Icons.engineering_rounded,
      'color': Colors.blue,
    },
    {
      'id': '22',
      'name': 'City Economic Management Office',
      'location': 'City Hall',
      'contact': '+63 83 553-8448',
      'icon': Icons.business_center_rounded,
      'color': Colors.amber,
    },
    {
      'id': '23',
      'name': 'City Housing and Land Office',
      'location': 'City Hall',
      'contact': '+63 83 553-3089',
      'icon': Icons.home_work_rounded,
      'color': Colors.blue,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Government Offices',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textDark,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${_offices.length} offices available',
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppTheme.textLight,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryBlue.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.apartment_rounded,
                        size: 14,
                        color: AppTheme.primaryBlue,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${_offices.length}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryBlue,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search offices...',
                  prefixIcon: Icon(Icons.search_rounded, color: AppTheme.textLight),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ),
          ),
          // List
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              itemCount: _offices.length,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final office = _offices[index];
                return _buildOfficeCard(office);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOfficeCard(Map<String, dynamic> office) {
    final Color accent = office['color'] as Color;
    final bool hasContact = office['contact'] != null && office['contact'] != 'N/A';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                // Icon
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    office['icon'],
                    size: 20,
                    color: accent,
                  ),
                ),
                const SizedBox(width: 12),
                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        office['name'],
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textDark,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        office['location'] ?? 'City Hall',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppTheme.textLight,
                        ),
                      ),
                      if (hasContact) ...[
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            const Icon(
                              Icons.phone_rounded,
                              size: 12,
                              color: AppTheme.textLight,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                office['contact'],
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppTheme.primaryBlue,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                      if (office['email'] != null && office['email'] != '') ...[
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            const Icon(
                              Icons.email_rounded,
                              size: 12,
                              color: AppTheme.textLight,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                office['email'],
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: AppTheme.textLight,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                // Call button
                if (hasContact)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryBlue.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: InkWell(
                      onTap: () => _makeCall(office['contact']),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.phone_rounded,
                            size: 14,
                            color: AppTheme.primaryBlue,
                          ),
                          SizedBox(width: 2),
                          Text(
                            'Call',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.primaryBlue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _makeCall(String number) async {
    // Extract first phone number from the contact string
    final phoneMatch = RegExp(r'\+?[\d\s-]+').firstMatch(number);
    if (phoneMatch != null) {
      final phoneNumber = phoneMatch.group(0)!.replaceAll(' ', '').replaceAll('-', '');
      final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
      try {
        if (await canLaunchUrl(phoneUri)) {
          await launchUrl(phoneUri);
        }
      } catch (e) {
        // Ignore errors
      }
    }
  }
}