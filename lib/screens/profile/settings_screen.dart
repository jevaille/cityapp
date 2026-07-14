import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          _buildSection(
            'App Settings',
            [
              _buildSwitchTile(
                'Dark Mode',
                'Enable dark theme',
                false,
                (value) {
                  // TODO: Toggle dark mode
                },
              ),
              _buildSwitchTile(
                'Notifications',
                'Enable push notifications',
                true,
                (value) {
                  // TODO: Toggle notifications
                },
              ),
              _buildSwitchTile(
                'Location Services',
                'Allow location access',
                true,
                (value) {
                  // TODO: Toggle location services
                },
              ),
            ],
          ),
          _buildSection(
            'Data Settings',
            [
              _buildTile(
                Icons.download,
                'Download Data',
                'Download your personal data',
                () {
                  // TODO: Download data
                },
              ),
              _buildTile(
                Icons.delete,
                'Clear Cache',
                'Clear app cache and temporary data',
                () {
                  // TODO: Clear cache
                },
              ),
            ],
          ),
          _buildSection(
            'About',
            [
              _buildTile(
                Icons.info,
                'App Version',
                'Version 1.0.0',
                () {},
              ),
              _buildTile(
                Icons.privacy_tip,
                'Privacy Policy',
                'Read our privacy policy',
                () {
                  // TODO: Show privacy policy
                },
              ),
              _buildTile(
                Icons.description,
                'Terms of Service',
                'Read our terms of service',
                () {
                  // TODO: Show terms of service
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 16, bottom: 8),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ),
        Column(
          children: children.map((child) {
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: child,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSwitchTile(
    String title,
    String subtitle,
    bool value,
    Function(bool) onChanged,
  ) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: onChanged,
    );
  }

  Widget _buildTile(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title),
      subtitle: Text(
        subtitle,
        style: const TextStyle(fontSize: 12),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}