import 'package:flutter/material.dart';
import '../../../app/theme.dart';
import '../../../models/government_service.dart';
import 'government_service_card.dart';

class GovernmentSection extends StatelessWidget {
  const GovernmentSection({
    super.key,
    required this.title,
    required this.services,
    required this.onServiceTap,
  });

  final String title;
  final List<GovernmentService> services;
  final Function(GovernmentService) onServiceTap;

  @override
  Widget build(BuildContext context) {
    if (services.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 0, 0, 12),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppTheme.textDark,
                letterSpacing: -0.2,
              ),
            ),
          ),
          // Services Grid
          Container(
            decoration: BoxDecoration(
              color: AppTheme.cardBg,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppTheme.borderLight.withValues(alpha: 0.5),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: services.length,
                itemBuilder: (context, index) {
                  return GovernmentServiceCard(
                    service: services[index],
                    onTap: () => onServiceTap(services[index]),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
