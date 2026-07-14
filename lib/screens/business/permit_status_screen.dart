import 'package:flutter/material.dart';

class PermitStatusScreen extends StatelessWidget {
  const PermitStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Permit Status'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 3,
        itemBuilder: (context, index) {
          final statuses = ['Approved', 'Pending', 'Under Review'];
          final status = statuses[index];
          Color statusColor;
          IconData statusIcon;

          switch (status) {
            case 'Approved':
              statusColor = Colors.green;
              statusIcon = Icons.check_circle;
              break;
            case 'Pending':
              statusColor = Colors.orange;
              statusIcon = Icons.pending;
              break;
            case 'Under Review':
              statusColor = Colors.blue;
              statusIcon = Icons.pending_actions; // Fixed: changed from 'review' to 'pending_actions'
              break;
            default:
              statusColor = Colors.grey;
              statusIcon = Icons.help;
          }

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Business Permit #12345',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'ABC Store',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: statusColor.withValues(alpha: 0.1), // Fixed: withOpacity -> withValues
                        ),
                        child: Row(
                          children: [
                            Icon(
                              statusIcon,
                              size: 14,
                              color: statusColor,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              status,
                              style: TextStyle(
                                fontSize: 12,
                                color: statusColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Applied on Dec 15, 2024',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  const Text(
                    'Expires on Dec 15, 2025',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}