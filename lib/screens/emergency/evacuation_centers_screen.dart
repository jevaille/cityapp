import 'package:flutter/material.dart';

class EvacuationCentersScreen extends StatelessWidget {
  const EvacuationCentersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Evacuation Centers'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 4,
        itemBuilder: (context, index) {
          final centers = [
            {
              'name': 'Community Center A',
              'address': '123 Main Street',
              'capacity': '200 people',
              'status': 'Open',
            },
            {
              'name': 'School Gymnasium',
              'address': '456 School Road',
              'capacity': '300 people',
              'status': 'Open',
            },
            {
              'name': 'City Hall',
              'address': '789 Government Ave',
              'capacity': '150 people',
              'status': 'Limited',
            },
            {
              'name': 'Sports Complex',
              'address': '321 Sports Drive',
              'capacity': '500 people',
              'status': 'Open',
            },
          ];
          final center = centers[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.location_city,
                        color: Colors.blue,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              center['name']!,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              center['address']!,
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.people,
                        size: 14,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Capacity: ${center['capacity']}',
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: center['status'] == 'Open'
                              ? Colors.green.withValues(alpha: 0.1)
                              : Colors.orange.withValues(alpha: 0.1),
                        ),
                        child: Text(
                          center['status']!,
                          style: TextStyle(
                            fontSize: 12,
                            color: center['status'] == 'Open'
                                ? Colors.green
                                : Colors.orange,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
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