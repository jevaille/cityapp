import 'package:flutter/material.dart';
import '../../app/theme.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<Map<String, dynamic>> _notifications = [
    {
      'title': 'City Budget Review',
      'message': 'Public hearing scheduled for next week',
      'time': '2 hours ago',
      'isRead': false,
      'icon': Icons.campaign_outlined,
      'color': AppTheme.primaryBlue,
    },
    {
      'title': 'Permit Approved',
      'message': 'Your business permit has been approved',
      'time': '1 day ago',
      'isRead': false,
      'icon': Icons.approval_outlined,
      'color': Colors.green,
    },
    {
      'title': 'Event Reminder',
      'message': 'City Festival happening this weekend',
      'time': '2 days ago',
      'isRead': true,
      'icon': Icons.event_outlined,
      'color': Colors.blue,
    },
    {
      'title': 'Report Update',
      'message': 'Your report has been resolved',
      'time': '3 days ago',
      'isRead': true,
      'icon': Icons.flag_outlined,
      'color': Colors.orange,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Mark all as read
            },
            child: const Text(
              'Mark all read',
              style: TextStyle(
                color: AppTheme.primaryBlue,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _notifications.length,
        itemBuilder: (context, index) {
          final notification = _notifications[index];
          return Card(
            elevation: 0,
            margin: const EdgeInsets.only(bottom: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                color: notification['isRead'] == false
                    ? AppTheme.primaryBlue
                    : Colors.grey.shade200,
                width: notification['isRead'] == false ? 1.5 : 1,
              ),
            ),
            child: ListTile(
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: (notification['color'] as Color).withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  notification['icon'],
                  color: notification['color'],
                  size: 20,
                ),
              ),
              title: Text(
                notification['title'],
                style: TextStyle(
                  fontWeight: notification['isRead'] == false
                      ? FontWeight.w600
                      : FontWeight.w400,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(notification['message']),
                  const SizedBox(height: 4),
                  Text(
                    notification['time'],
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.textLight,
                    ),
                  ),
                ],
              ),
              trailing: notification['isRead'] == false
                  ? Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppTheme.primaryBlue,
                        shape: BoxShape.circle,
                      ),
                    )
                  : null,
              onTap: () {
                // Mark as read
              },
            ),
          );
        },
      ),
    );
  }
}