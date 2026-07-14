import 'package:flutter/material.dart';
import '../../../app/theme.dart';
import '../../../widgets/common/page_background.dart';

class PermitsPage extends StatefulWidget {
  const PermitsPage({super.key});

  @override
  State<PermitsPage> createState() => _PermitsPageState();
}

class _PermitsPageState extends State<PermitsPage> {
  final List<Map<String, dynamic>> _permits = [
    {
      'id': 'PER-2024-001',
      'name': 'Business Permit',
      'type': 'Business',
      'status': 'Active',
      'expiry': 'Dec 31, 2024',
      'icon': Icons.business_center_rounded,
      'color': Colors.blue,
      'description': 'Mayor\'s Permit for business operations',
    },
    {
      'id': 'PER-2024-002',
      'name': 'Barangay Clearance',
      'type': 'Clearance',
      'status': 'Active',
      'expiry': 'Jan 15, 2025',
      'icon': Icons.home_work_rounded,
      'color': Colors.green,
      'description': 'Barangay clearance for residency',
    },
    {
      'id': 'PER-2024-003',
      'name': 'Building Permit',
      'type': 'Construction',
      'status': 'Pending',
      'expiry': 'N/A',
      'icon': Icons.construction_rounded,
      'color': Colors.orange,
      'description': 'Building permit for commercial construction',
    },
    {
      'id': 'PER-2024-004',
      'name': 'Sanitary Permit',
      'type': 'Health',
      'status': 'Expired',
      'expiry': 'Mar 10, 2024',
      'icon': Icons.health_and_safety_rounded,
      'color': Colors.red,
      'description': 'Sanitary permit for food establishment',
    },
    {
      'id': 'PER-2024-005',
      'name': 'Fire Safety Inspection',
      'type': 'Safety',
      'status': 'Active',
      'expiry': 'Oct 20, 2024',
      'icon': Icons.fire_extinguisher_rounded,
      'color': Colors.purple,
      'description': 'Fire safety inspection certificate',
    },
    {
      'id': 'PER-2024-006',
      'name': 'Zoning Clearance',
      'type': 'Property',
      'status': 'Pending',
      'expiry': 'N/A',
      'icon': Icons.map_rounded,
      'color': Colors.teal,
      'description': 'Zoning clearance for property use',
    },
  ];

  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Active', 'Pending', 'Expired'];

  @override
  Widget build(BuildContext context) {
    return PageBackground(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Permits',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textDark,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Apply and manage your government permits',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppTheme.textLight,
                        ),
                      ),
                    ),
                    // Quick stats
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryBlue.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${_permits.length} Permits',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.primaryBlue,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Filter Chips
          Container(
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _filters.length,
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final filter = _filters[index];
                final isSelected = _selectedFilter == filter;
                return FilterChip(
                  label: Text(
                    filter,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                      color: isSelected ? Colors.white : AppTheme.textMedium,
                    ),
                  ),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      _selectedFilter = filter;
                    });
                  },
                  backgroundColor: Colors.white,
                  selectedColor: AppTheme.primaryBlue,
                  side: BorderSide(
                    color: isSelected ? AppTheme.primaryBlue : AppTheme.borderLight,
                    width: 1.5,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                );
              },
            ),
          ),
          // Quick Action Cards
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: _buildQuickActionCard(
                    Icons.app_registration_rounded,
                    'Apply Permit',
                    AppTheme.primaryBlue,
                    () {},
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildQuickActionCard(
                    Icons.autorenew_rounded,
                    'Renew',
                    AppTheme.success,
                    () {},
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildQuickActionCard(
                    Icons.check_circle_rounded,
                    'Check Status',
                    AppTheme.warning,
                    () {},
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildQuickActionCard(
                    Icons.description_rounded,
                    'Requirements',
                    AppTheme.info,
                    () {},
                  ),
                ),
              ],
            ),
          ),
          // Permit List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              itemCount: _permits.length,
              itemBuilder: (context, index) {
                final permit = _permits[index];
                // Filter logic
                if (_selectedFilter != 'All' && permit['status'] != _selectedFilter) {
                  return const SizedBox.shrink();
                }
                return _buildPermitCard(permit);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionCard(IconData icon, String label, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppTheme.borderLight.withValues(alpha: 0.5),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 20,
                color: color,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: AppTheme.textDark,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPermitCard(Map<String, dynamic> permit) {
    Color statusColor;
    IconData statusIcon;
    String statusLabel;

    switch (permit['status']) {
      case 'Active':
        statusColor = AppTheme.success;
        statusIcon = Icons.check_circle_rounded;
        statusLabel = 'Active';
        break;
      case 'Pending':
        statusColor = AppTheme.warning;
        statusIcon = Icons.pending_rounded;
        statusLabel = 'Pending';
        break;
      case 'Expired':
        statusColor = AppTheme.error;
        statusIcon = Icons.cancel_rounded;
        statusLabel = 'Expired';
        break;
      default:
        statusColor = AppTheme.textLight;
        statusIcon = Icons.help_rounded;
        statusLabel = 'Unknown';
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppTheme.borderLight.withValues(alpha: 0.5),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // Navigate to permit details
          },
          borderRadius: BorderRadius.circular(14),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: (permit['color'] as Color).withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        permit['icon'],
                        color: permit['color'],
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            permit['name'],
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textDark,
                            ),
                          ),
                          Text(
                            permit['id'],
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppTheme.textLight,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            statusIcon,
                            size: 14,
                            color: statusColor,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            statusLabel,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: statusColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  permit['description'],
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppTheme.textMedium,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.borderLight.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        permit['type'],
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppTheme.textLight,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_today_rounded,
                          size: 12,
                          color: AppTheme.textLight,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          permit['expiry'],
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppTheme.textLight,
                          ),
                        ),
                      ],
                    ),
                    if (permit['status'] == 'Expired')
                      const Spacer()
                    else
                      const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryBlue.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'View Details',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.primaryBlue,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}