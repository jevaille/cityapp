import 'package:flutter/material.dart';

class OfficesScreen extends StatelessWidget {
  const OfficesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Government Offices'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 6,
        itemBuilder: (context, index) {
          final offices = [
            {'name': 'City Hall', 'address': '1 City Hall Plaza', 'phone': '555-0101'},
            {'name': 'Public Works', 'address': '200 Service Road', 'phone': '555-0102'},
            {'name': 'Health Department', 'address': '300 Health Blvd', 'phone': '555-0103'},
            {'name': 'Education Office', 'address': '400 School Ave', 'phone': '555-0104'},
            {'name': 'Police Station', 'address': '500 Justice Way', 'phone': '555-0105'},
            {'name': 'Fire Department', 'address': '600 Safety Lane', 'phone': '555-0106'},
          ];
          final office = offices[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.account_balance,
                  color: Colors.blue,
                  size: 20,
                ),
              ),
              title: Text(
                office['name']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(office['address']!),
                  Text('Phone: ${office['phone']}'),
                ],
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            ),
          );
        },
      ),
    );
  }
}