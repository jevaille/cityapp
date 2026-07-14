import 'package:flutter/material.dart';
import '../../../app/theme.dart';
import '../../../widgets/common/page_background.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _darkMode = false;
  bool _notifications = true;
  bool _locationServices = true;
  bool _biometricLogin = false;
  bool _offlineMode = false;
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return PageBackground(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const Text(
              'Settings',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppTheme.textDark,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Customize your app experience',
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.textLight,
              ),
            ),
            const SizedBox(height: 20),
            // Account Section
            _buildSection('Account'),
            const SizedBox(height: 8),
            _buildSettingsTile(
              icon: Icons.person_rounded,
              title: 'Profile',
              subtitle: 'Manage your personal information',
              onTap: () {},
            ),
            _buildSettingsTile(
              icon: Icons.security_rounded,
              title: 'Security',
              subtitle: 'Password and security settings',
              onTap: () {},
            ),
            _buildSettingsTile(
              icon: Icons.email_rounded,
              title: 'Email Notifications',
              subtitle: 'Receive updates via email',
              onTap: () {},
            ),
            const SizedBox(height: 16),
            // Preferences Section
            _buildSection('Preferences'),
            const SizedBox(height: 8),
            _buildSwitchTile(
              icon: Icons.dark_mode_rounded,
              title: 'Dark Mode',
              subtitle: 'Switch to dark theme',
              value: _darkMode,
              onChanged: (value) {
                setState(() {
                  _darkMode = value;
                });
              },
            ),
            _buildSwitchTile(
              icon: Icons.notifications_rounded,
              title: 'Push Notifications',
              subtitle: 'Receive app notifications',
              value: _notifications,
              onChanged: (value) {
                setState(() {
                  _notifications = value;
                });
              },
            ),
            _buildSwitchTile(
              icon: Icons.location_on_rounded,
              title: 'Location Services',
              subtitle: 'Allow access to your location',
              value: _locationServices,
              onChanged: (value) {
                setState(() {
                  _locationServices = value;
                });
              },
            ),
            _buildSwitchTile(
              icon: Icons.fingerprint_rounded,
              title: 'Biometric Login',
              subtitle: 'Use fingerprint or face ID',
              value: _biometricLogin,
              onChanged: (value) {
                setState(() {
                  _biometricLogin = value;
                });
              },
            ),
            _buildSwitchTile(
              icon: Icons.wifi_rounded,
              title: 'Offline Mode',
              subtitle: 'Access content without internet',
              value: _offlineMode,
              onChanged: (value) {
                setState(() {
                  _offlineMode = value;
                });
              },
            ),
            const SizedBox(height: 16),
            // Language Section
            _buildSection('Language'),
            const SizedBox(height: 8),
            _buildDropdownTile(
              icon: Icons.language_rounded,
              title: 'App Language',
              subtitle: 'Choose your preferred language',
              value: _selectedLanguage,
              options: ['English', 'Filipino', 'Cebuano', 'Ilocano'],
              onChanged: (value) {
                setState(() {
                  _selectedLanguage = value;
                });
              },
            ),
            const SizedBox(height: 16),
            // Data & Storage
            _buildSection('Data & Storage'),
            const SizedBox(height: 8),
            _buildSettingsTile(
              icon: Icons.storage_rounded,
              title: 'Storage',
              subtitle: 'Clear cache and manage storage',
              trailing: '125 MB',
              onTap: () {},
            ),
            _buildSettingsTile(
              icon: Icons.download_rounded,
              title: 'Downloads',
              subtitle: 'Manage downloaded content',
              onTap: () {},
            ),
            const SizedBox(height: 16),
            // Support
            _buildSection('Support'),
            const SizedBox(height: 8),
            _buildSettingsTile(
              icon: Icons.help_rounded,
              title: 'Help Center',
              subtitle: 'FAQs and support articles',
              onTap: () {},
            ),
            _buildSettingsTile(
              icon: Icons.feedback_rounded,
              title: 'Send Feedback',
              subtitle: 'Help us improve the app',
              onTap: () {},
            ),
            _buildSettingsTile(
              icon: Icons.star_rounded,
              title: 'Rate the App',
              subtitle: 'Rate us on the app store',
              onTap: () {},
            ),
            _buildSettingsTile(
              icon: Icons.share_rounded,
              title: 'Share the App',
              subtitle: 'Share with friends and family',
              onTap: () {},
            ),
            const SizedBox(height: 16),
            // About
            _buildSection('About'),
            const SizedBox(height: 8),
            _buildSettingsTile(
              icon: Icons.info_rounded,
              title: 'About CityServe',
              subtitle: 'Version 1.0.0',
              onTap: () {},
            ),
            _buildSettingsTile(
              icon: Icons.privacy_tip_rounded,
              title: 'Privacy Policy',
              subtitle: 'Read our privacy policy',
              onTap: () {},
            ),
            _buildSettingsTile(
              icon: Icons.description_rounded,
              title: 'Terms of Service',
              subtitle: 'Read our terms of service',
              onTap: () {},
            ),
            const SizedBox(height: 16),
            // Logout Button
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: AppTheme.borderLight.withValues(alpha: 0.5),
                ),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    _showLogoutDialog(context);
                  },
                  borderRadius: BorderRadius.circular(14),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.logout_rounded,
                          color: Colors.red,
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Logout',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.5,
        color: AppTheme.textLight,
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    String? trailing,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.borderLight.withValues(alpha: 0.5),
        ),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.primaryBlue.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 20,
            color: AppTheme.primaryBlue,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppTheme.textDark,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            fontSize: 12,
            color: AppTheme.textLight,
          ),
        ),
        trailing: trailing != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    trailing,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppTheme.textLight,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.chevron_right_rounded,
                    size: 20,
                    color: AppTheme.textLight,
                  ),
                ],
              )
            : const Icon(
                Icons.chevron_right_rounded,
                size: 20,
                color: AppTheme.textLight,
              ),
        onTap: onTap,
      ),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.borderLight.withValues(alpha: 0.5),
        ),
      ),
      child: SwitchListTile(
        secondary: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.primaryBlue.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 20,
            color: AppTheme.primaryBlue,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppTheme.textDark,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            fontSize: 12,
            color: AppTheme.textLight,
          ),
        ),
        value: value,
        onChanged: onChanged,
        activeThumbColor: AppTheme.primaryBlue,
      ),
    );
  }

  Widget _buildDropdownTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required String value,
    required List<String> options,
    required ValueChanged<String> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.borderLight.withValues(alpha: 0.5),
        ),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.primaryBlue.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 20,
            color: AppTheme.primaryBlue,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppTheme.textDark,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            fontSize: 12,
            color: AppTheme.textLight,
          ),
        ),
        trailing: DropdownButton<String>(
          value: value,
          items: options.map((String option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(
                option,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppTheme.textDark,
                ),
              ),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              onChanged(value);
            }
          },
          underline: Container(),
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppTheme.textLight,
          ),
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppTheme.primaryBlue,
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text(
          'Logout',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          'Are you sure you want to logout?',
          style: TextStyle(
            fontSize: 16,
            color: AppTheme.textMedium,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              foregroundColor: AppTheme.textMedium,
            ),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/login');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}