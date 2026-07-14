import 'package:flutter/material.dart';

class OfficialsScreen extends StatelessWidget {
  const OfficialsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('City Officials'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 4,
        itemBuilder: (context, index) {
          final officials = [
            {'name': 'John Doe', 'position': 'Mayor', 'office': 'City Hall', 'email': 'mayor@city.gov'},
            {'name': 'Jane Smith', 'position': 'City Manager', 'office': 'City Hall', 'email': 'manager@city.gov'},
            {'name': 'Bob Johnson', 'position': 'Council Member', 'office': 'City Hall', 'email': 'council@city.gov'},
            {'name': 'Alice Brown', 'position': 'City Clerk', 'office': 'City Hall', 'email': 'clerk@city.gov'},
          ];
          final official = officials[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.blue[100],
                    child: Text(
                      official['name']!.substring(0, 1).toUpperCase(),
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          official['name']!,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          official['position']!,
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          official['office']!,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          official['email']!,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.blue,
                          ),
                        ),
                      ],
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