import 'package:flutter/material.dart';
import '../../app/theme.dart';  // Changed to relative import

class BusinessBureauScreen extends StatelessWidget {
  const BusinessBureauScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text(
          'Business Bureau',
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
              'Business Services',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppTheme.textDark,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Apply for permits, renewals, and check status',
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
                  'Apply Permit',
                  Icons.app_registration,
                  Colors.blue,
                  () {
                    // Navigate to permit application
                    Navigator.pushNamed(context, '/permit-application');
                  },
                ),
                _buildGridItem(
                  context,
                  'Renew Permit',
                  Icons.autorenew,
                  Colors.green,
                  () {
                    // Navigate to permit renewal
                    Navigator.pushNamed(context, '/permit-renewal');
                  },
                ),
                _buildGridItem(
                  context,
                  'Check Status',
                  Icons.check_circle,
                  Colors.orange,
                  () {
                    // Navigate to permit status
                    Navigator.pushNamed(context, '/permit-status');
                  },
                ),
                _buildGridItem(
                  context,
                  'Business Directory',
                  Icons.business_center,
                  Colors.purple,
                  () {
                    // Navigate to business directory
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