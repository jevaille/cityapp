import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../app/theme.dart';

class EventCardWithImage extends StatelessWidget {
  const EventCardWithImage({
    super.key,
    required this.title,
    required this.location,
    required this.imageUrl,
    required this.startTime,
    required this.category,
    required this.currentAttendees,
    required this.maxAttendees,
    this.onTap,
  });

  final String title;
  final String location;
  final String imageUrl;
  final DateTime startTime;
  final String category;
  final int currentAttendees;
  final int maxAttendees;
  final VoidCallback? onTap;

  String _formatDate(DateTime date) {
    const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    final hour = date.hour == 0
        ? 12
        : date.hour > 12
            ? date.hour - 12
            : date.hour;
    final minute = date.minute.toString().padLeft(2, '0');
    final period = date.hour >= 12 ? 'PM' : 'AM';

    return '${weekdays[date.weekday - 1]}, ${date.day.toString().padLeft(2, '0')} '
        '${months[date.month - 1]}, ${date.year} - '
        '${hour.toString().padLeft(2, '0')}:$minute $period';
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'concert':
        return const Color(0xFFE91E63);
      case 'sports':
        return const Color(0xFF2196F3);
      case 'education':
        return const Color(0xFF4CAF50);
      case 'government':
        return const Color(0xFF9C27B0);
      case 'community':
        return const Color(0xFFFF9800);
      default:
        return AppTheme.primaryBlue;
    }
  }

  @override
  Widget build(BuildContext context) {
    final interestedCount = currentAttendees < 1000
        ? currentAttendees.toString()
        : '${(currentAttendees / 1000).toStringAsFixed(1)}K';

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: LayoutBuilder(
          builder: (context, constraints) {
            const maxImageHeight = 176.0;
            const minImageHeight = 96.0;
            const compactCardTextHeight = 115.0;
            final titleMaxLines =
                constraints.hasBoundedHeight && constraints.maxHeight < 300
                    ? 1
                    : 2;
            final imageHeight = constraints.hasBoundedHeight
                ? (constraints.maxHeight - compactCardTextHeight)
                    .clamp(minImageHeight, maxImageHeight)
                    .toDouble()
                : maxImageHeight;

            return Padding(
              padding: const EdgeInsets.all(4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          imageUrl: imageUrl,
                          height: imageHeight,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            height: imageHeight,
                            color: AppTheme.borderLight,
                            child: Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: _getCategoryColor(category),
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            height: imageHeight,
                            color: AppTheme.borderLight,
                            child: const Icon(
                              Icons.image_not_supported_outlined,
                              color: AppTheme.textLight,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 16,
                        bottom: -14,
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: AppTheme.borderLight),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.08),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.star_border_rounded,
                            size: 19,
                            color: AppTheme.primaryBlue,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _formatDate(startTime),
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppTheme.textLight,
                            height: 1.25,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.textDark,
                            height: 1.2,
                          ),
                          maxLines: titleMaxLines,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          location,
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppTheme.textLight,
                            height: 1.25,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '$interestedCount+ Interested',
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppTheme.textDark,
                            fontWeight: FontWeight.w500,
                            height: 1.2,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
