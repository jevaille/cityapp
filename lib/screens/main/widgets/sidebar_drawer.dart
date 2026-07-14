import 'package:flutter/material.dart';
import '../../../app/theme.dart';

class SidebarDrawer extends StatelessWidget {
  const SidebarDrawer({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
    this.embedded = false,
    this.width = 280,
  });
  final int selectedIndex;
  final Function(int) onItemSelected;
  final bool embedded;
  final double width;

  final List<SidebarItem> _items = const [
    SidebarItem(icon: Icons.dashboard_rounded, label: 'Dashboard', index: 0),
    SidebarItem(icon: Icons.newspaper_rounded, label: 'News', index: 1),
    SidebarItem(icon: Icons.event_rounded, label: 'Events', index: 2),
    SidebarItem(icon: Icons.work_rounded, label: 'Jobs', index: 3),
    SidebarItem(icon: Icons.approval_rounded, label: 'Permits', index: 4),
    SidebarItem(icon: Icons.flag_rounded, label: 'Reports', index: 5),
    SidebarItem(icon: Icons.account_balance_rounded, label: 'Directory', index: 8),
    SidebarItem(icon: Icons.account_balance, label: 'Government Services', index: 9),
    SidebarItem(icon: Icons.info_rounded, label: 'Information', index: 10),
    SidebarItem(icon: Icons.emergency_rounded, label: 'Emergency', index: 6),
    SidebarItem(icon: Icons.location_on_rounded, label: 'Maps', index: 7),
    SidebarItem(icon: Icons.videocam_rounded, label: 'CCTV', index: 11),
  ];

  final List<SidebarItem> _bottomItems = const [
    SidebarItem(icon: Icons.settings_rounded, label: 'Settings', index: 12),
    SidebarItem(icon: Icons.person_rounded, label: 'Profile', index: 13),
  ];

  @override
  Widget build(BuildContext context) {
    // Calculate half the screen width
    final screenWidth = MediaQuery.of(context).size.width;
    final drawerWidth = screenWidth / 2;

    final content = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Header with Logo - No rounded corners
        Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(
            16,
            MediaQuery.of(context).padding.top + 24,
            16,
            16,
          ),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppTheme.primaryBlue,
                AppTheme.primaryBlueLight,
              ],
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/logos/gensan.png',
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.account_balance_rounded,
                          color: Colors.white,
                          size: 24,
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Governance',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.3,
                      ),
                    ),
                    SizedBox(height: 1),
                    Text(
                      'General Santos City',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        _sectionLabel('MENU'),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemCount: _items.length,
            itemBuilder: (context, index) {
              final item = _items[index];
              final isSelected = selectedIndex == item.index;
              return _buildDrawerItem(
                icon: item.icon,
                label: item.label,
                isSelected: isSelected,
                onTap: () => onItemSelected(item.index),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Divider(
            height: 1,
            color: AppTheme.borderLight.withValues(alpha: 0.6),
          ),
        ),
        const SizedBox(height: 6),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: _bottomItems.map((item) {
              final isSelected = selectedIndex == item.index;
              return _buildDrawerItem(
                icon: item.icon,
                label: item.label,
                isSelected: isSelected,
                onTap: () => onItemSelected(item.index),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );

    if (embedded) {
      return SizedBox(
        width: drawerWidth,
        child: Material(
          color: Colors.white,
          elevation: 8,
          child: content,
        ),
      );
    }

    return Drawer(
      width: drawerWidth,
      backgroundColor: Colors.white,
      child: content,
    );
  }

  Widget _sectionLabel(String label) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 2, 16, 6),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
            color: AppTheme.textLight.withValues(alpha: 0.8),
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Material(
        color: isSelected ? AppTheme.primaryBlueSurface : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppTheme.primaryBlue.withValues(alpha: 0.12)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    icon,
                    size: 18,
                    color: isSelected ? AppTheme.primaryBlue : AppTheme.textLight,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                      color: isSelected ? AppTheme.primaryBlue : AppTheme.textMedium,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (isSelected)
                  Container(
                    width: 5,
                    height: 5,
                    decoration: const BoxDecoration(
                      color: AppTheme.primaryBlue,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SidebarItem {
  const SidebarItem({
    required this.icon,
    required this.label,
    required this.index,
  });
  final IconData icon;
  final String label;
  final int index;
}