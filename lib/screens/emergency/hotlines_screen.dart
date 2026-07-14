import 'package:flutter/material.dart';

class HotlinesScreen extends StatelessWidget {
  const HotlinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency Hotlines'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 6,
        itemBuilder: (context, index) {
          final hotlines = [
            {'name': 'Police', 'number': '911'},
            {'name': 'Fire Department', 'number': '911'},
            {'name': 'Ambulance', 'number': '911'},
            {'name': 'Rescue', 'number': '112'},
            {'name': 'Disaster Response', 'number': '113'},
            {'name': 'Emergency Services', 'number': '118'},
          ];
          final hotline = hotlines[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.phone,
                  color: Colors.red,
                  size: 20,
                ),
              ),
              title: Text(
                hotline['name']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(hotline['number']!),
              trailing: ElevatedButton.icon(
                onPressed: () {
                  // TODO: Call hotline
                },
                icon: const Icon(Icons.call, size: 16),
                label: const Text('Call'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(0, 36),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}