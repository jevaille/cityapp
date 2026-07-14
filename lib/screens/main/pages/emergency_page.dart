import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../app/theme.dart';
import '../../../widgets/common/page_background.dart';

class EmergencyPage extends StatelessWidget {
  EmergencyPage({super.key});

  // Regular list (not const) to allow non-constant values
  final List<Map<String, dynamic>> _hotlines = [
    {
      'name': 'Police Emergency',
      'number': '911',
      'icon': Icons.local_police,
      'color': Colors.blue,
      'description': 'National Emergency Hotline',
    },
    {
      'name': 'PNP General Santos',
      'number': '083-552-1234',
      'icon': Icons.local_police,
      'color': Colors.blue,
      'description': 'General Santos City Police Station',
    },
    {
      'name': 'Fire Department',
      'number': '083-552-4321',
      'icon': Icons.local_fire_department,
      'color': Colors.red,
      'description': 'Bureau of Fire Protection - GenSan',
    },
    {
      'name': 'Ambulance / Rescue',
      'number': '083-552-5678',
      'icon': Icons.local_hospital,
      'color': Colors.green,
      'description': 'Emergency Medical Services',
    },
    {
      'name': 'Coast Guard',
      'number': '083-552-8765',
      'icon': Icons.directions_boat,
      'color': Colors.cyan,
      'description': 'Philippine Coast Guard - GenSan',
    },
    {
      'name': 'Red Cross',
      'number': '143',
      'icon': Icons.medical_services,
      'color': Colors.red,
      'description': 'Philippine Red Cross - GenSan',
    },
    {
      'name': 'Disaster Response',
      'number': '083-552-3456',
      'icon': Icons.warning,
      'color': Colors.orange,
      'description': 'City Disaster Risk Reduction Office',
    },
    {
      'name': 'DOH Hotline',
      'number': '1555',
      'icon': Icons.health_and_safety,
      'color': Colors.green,
      'description': 'Department of Health Emergency',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return PageBackground(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Emergency',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textDark,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Quick access to emergency services in General Santos',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.textLight,
                  ),
                ),
              ],
            ),
          ),
          // Emergency SOS Button
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.red,
                  Colors.redAccent,
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.red.withValues(alpha: 0.3),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: InkWell(
              onTap: () {
                _makeCall(context, '911');
              },
              borderRadius: BorderRadius.circular(16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.sos,
                      color: Colors.red,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SOS Emergency',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Call 911 for immediate assistance',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.phone_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                ],
              ),
            ),
          ),
          // Quick Action Cards
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: _buildQuickActionCard(
                    Icons.phone_in_talk,
                    'Hotlines',
                    AppTheme.primaryBlue,
                    () {},
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildQuickActionCard(
                    Icons.location_on,
                    'Evacuation Centers',
                    AppTheme.warning,
                    () {},
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildQuickActionCard(
                    Icons.safety_check,
                    'Safety Tips',
                    AppTheme.success,
                    () {},
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildQuickActionCard(
                    Icons.share_location,
                    'Share Location',
                    Colors.purple,
                    () {},
                  ),
                ),
              ],
            ),
          ),
          // Hotlines List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              itemCount: _hotlines.length,
              itemBuilder: (context, index) {
                final hotline = _hotlines[index];
                return _buildHotlineCard(
                  context,
                  hotline['name']!,
                  hotline['number']!,
                  hotline['icon'],
                  hotline['color'],
                  hotline['description']!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionCard(IconData icon, String label, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppTheme.borderLight.withValues(alpha: 0.5),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 20,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w600,
                color: AppTheme.textDark,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHotlineCard(
    BuildContext context,
    String name,
    String number,
    IconData icon,
    Color color,
    String description,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppTheme.borderLight.withValues(alpha: 0.5),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                size: 22,
                color: color,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textDark,
                    ),
                  ),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.textLight,
                    ),
                  ),
                  Text(
                    number,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.primaryBlue,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: AppTheme.primaryBlue.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                onTap: () => _makeCall(context, number),
                child: const Row(
                  children: [
                    Icon(
                      Icons.phone_rounded,
                      size: 16,
                      color: AppTheme.primaryBlue,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Call',
                      style: TextStyle(
                        fontSize: 12,
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
    );
  }

  void _makeCall(BuildContext context, String number) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: number);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Call $number for emergency assistance'),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }
}