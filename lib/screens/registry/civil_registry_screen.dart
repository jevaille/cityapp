import 'package:flutter/material.dart';
import '../../app/theme.dart';  // Changed to relative import

class CivilRegistryScreen extends StatelessWidget {
  const CivilRegistryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text(
          'Civil Registry',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Civil Registry Services',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppTheme.textDark,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Request birth, marriage, and death certificates',
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.textMedium,
              ),
            ),
            const SizedBox(height: 24),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.1,
              children: [
                _buildGridItem(
                  context,
                  'Birth Certificate',
                  Icons.child_care,
                  Colors.blue,
                  () {
                    Navigator.pushNamed(context, '/birth-certificate');
                  },
                ),
                _buildGridItem(
                  context,
                  'Marriage Certificate',
                  Icons.favorite,
                  Colors.pink,
                  () {
                    Navigator.pushNamed(context, '/marriage-certificate');
                  },
                ),
                _buildGridItem(
                  context,
                  'Death Certificate',
                  Icons.mood_bad,
                  Colors.grey,
                  () {
                    Navigator.pushNamed(context, '/death-certificate');
                  },
                ),
                _buildGridItem(
                  context,
                  'Book Appointment',
                  Icons.calendar_today,
                  Colors.green,
                  () {
                    Navigator.pushNamed(context, '/appointment');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridItem(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: AppTheme.borderLight.withValues(alpha: 0.5),  // Fixed: withOpacity -> withValues
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),  // Fixed: withOpacity -> withValues
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 30,
                  color: color,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textDark,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}