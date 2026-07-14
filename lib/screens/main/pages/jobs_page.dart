import 'package:flutter/material.dart';
import '../../../app/theme.dart';
import '../../../widgets/common/page_background.dart';

class JobsPage extends StatefulWidget {
  const JobsPage({super.key});

  @override
  State<JobsPage> createState() => _JobsPageState();
}

class _JobsPageState extends State<JobsPage> {
  // Tab selection: true = Hiring, false = Looking for Job
  bool _isHiring = true;

  final List<Map<String, dynamic>> _hiringJobs = [
    {
      'title': 'Senior Flutter Developer',
      'company': 'Tech Solutions Inc.',
      'location': 'Makati City',
      'salary': '₱80,000 - ₱120,000',
      'type': 'Full-time',
      'posted': '2 days ago',
      'logo': Icons.code_rounded,
      'color': Colors.blue,
      'isFeatured': true,
    },
    {
      'title': 'City Planning Officer',
      'company': 'City Government of General Santos',
      'location': 'General Santos City',
      'salary': '₱45,000 - ₱60,000',
      'type': 'Full-time',
      'posted': '3 days ago',
      'logo': Icons.account_balance_rounded,
      'color': Colors.green,
      'isFeatured': false,
    },
    {
      'title': 'Public Health Nurse',
      'company': 'Department of Health - Region XII',
      'location': 'General Santos City',
      'salary': '₱35,000 - ₱45,000',
      'type': 'Full-time',
      'posted': '5 days ago',
      'logo': Icons.health_and_safety_rounded,
      'color': Colors.red,
      'isFeatured': false,
    },
    {
      'title': 'IT Support Specialist',
      'company': 'City IT Department',
      'location': 'General Santos City',
      'salary': '₱30,000 - ₱40,000',
      'type': 'Full-time',
      'posted': '1 week ago',
      'logo': Icons.computer_rounded,
      'color': Colors.purple,
      'isFeatured': false,
    },
    {
      'title': 'Community Development Officer',
      'company': 'Barangay Affairs Office',
      'location': 'General Santos City',
      'salary': '₱28,000 - ₱35,000',
      'type': 'Part-time',
      'posted': '1 week ago',
      'logo': Icons.people_rounded,
      'color': Colors.orange,
      'isFeatured': false,
    },
    {
      'title': 'Accounting Clerk',
      'company': 'City Treasurer\'s Office',
      'location': 'General Santos City',
      'salary': '₱25,000 - ₱32,000',
      'type': 'Full-time',
      'posted': '2 weeks ago',
      'logo': Icons.calculate_rounded,
      'color': Colors.teal,
      'isFeatured': false,
    },
  ];

  final List<Map<String, dynamic>> _lookingForJob = [
    {
      'title': 'Experienced Flutter Developer',
      'company': 'Available for Hire',
      'location': 'General Santos City',
      'experience': '5+ years',
      'salary': '₱70,000 - ₱100,000',
      'type': 'Full-time',
      'posted': '2 days ago',
      'logo': Icons.person_rounded,
      'color': Colors.teal,
      'isFeatured': true,
    },
    {
      'title': 'Fresh Graduate - IT',
      'company': 'Seeking Entry Level',
      'location': 'General Santos City',
      'experience': 'Fresh Graduate',
      'salary': '₱25,000 - ₱35,000',
      'type': 'Full-time',
      'posted': '3 days ago',
      'logo': Icons.school_rounded,
      'color': Colors.blue,
      'isFeatured': false,
    },
    {
      'title': 'Experienced Nurse',
      'company': 'Available for Hire',
      'location': 'General Santos City',
      'experience': '3+ years',
      'salary': '₱35,000 - ₱45,000',
      'type': 'Full-time',
      'posted': '5 days ago',
      'logo': Icons.health_and_safety_rounded,
      'color': Colors.red,
      'isFeatured': false,
    },
    {
      'title': 'Accounting Professional',
      'company': 'Seeking New Opportunity',
      'location': 'General Santos City',
      'experience': '4+ years',
      'salary': '₱30,000 - ₱40,000',
      'type': 'Full-time',
      'posted': '1 week ago',
      'logo': Icons.calculate_rounded,
      'color': Colors.teal,
      'isFeatured': false,
    },
    {
      'title': 'Community Worker',
      'company': 'Available for NGO Work',
      'location': 'General Santos City',
      'experience': '2+ years',
      'salary': '₱28,000 - ₱35,000',
      'type': 'Part-time',
      'posted': '1 week ago',
      'logo': Icons.people_rounded,
      'color': Colors.orange,
      'isFeatured': false,
    },
  ];

  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Full-time', 'Part-time', 'Featured'];

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
                  'Job Portal',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _isHiring 
                      ? '${_hiringJobs.length} jobs available in your area'
                      : '${_lookingForJob.length} job seekers available',
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppTheme.textLight,
                  ),
                ),
                const SizedBox(height: 14),
                // Modern Card Toggle
                _buildCardToggle(),
                const SizedBox(height: 14),
                // Search Bar
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppTheme.borderLight,
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search jobs, companies...',
                            hintStyle: TextStyle(
                              fontSize: 14,
                              color: AppTheme.textLight,
                            ),
                            prefixIcon: Icon(
                              Icons.search_rounded,
                              color: AppTheme.textLight,
                              size: 22,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 6),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.tune_rounded,
                            color: AppTheme.primaryBlue,
                            size: 22,
                          ),
                          style: IconButton.styleFrom(
                            backgroundColor: AppTheme.primaryBlue.withValues(alpha: 0.08),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Filter Chips
          Container(
            height: 48,
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
          // Job Listings with Fade Animation
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              switchInCurve: Curves.easeInOut,
              switchOutCurve: Curves.easeInOut,
              child: ListView.builder(
                key: ValueKey(_isHiring),
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                itemCount: _isHiring ? _hiringJobs.length : _lookingForJob.length,
                itemBuilder: (context, index) {
                  final job = _isHiring ? _hiringJobs[index] : _lookingForJob[index];
                  // Filter logic
                  if (_selectedFilter != 'All') {
                    if (_selectedFilter == 'Featured' && !job['isFeatured']) {
                      return const SizedBox.shrink();
                    }
                    if (_selectedFilter == 'Full-time' && job['type'] != 'Full-time') {
                      return const SizedBox.shrink();
                    }
                    if (_selectedFilter == 'Part-time' && job['type'] != 'Part-time') {
                      return const SizedBox.shrink();
                    }
                  }
                  return _buildJobCard(job);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------
  // Modern Card Toggle - Government Style
  // ---------------------------------------------------------------------
  Widget _buildCardToggle() {
    return Row(
      children: [
        Expanded(
          child: _buildToggleCard(
            icon: Icons.business_center_rounded,
            title: 'Hiring',
            count: _hiringJobs.length,
            isSelected: _isHiring,
            onTap: () {
              if (!_isHiring) {
                setState(() {
                  _isHiring = true;
                  _selectedFilter = 'All';
                });
              }
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildToggleCard(
            icon: Icons.person_search_rounded,
            title: 'Job Seekers',
            count: _lookingForJob.length,
            isSelected: !_isHiring,
            onTap: () {
              if (_isHiring) {
                setState(() {
                  _isHiring = false;
                  _selectedFilter = 'All';
                });
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildToggleCard({
    required IconData icon,
    required String title,
    required int count,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryBlue : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? AppTheme.primaryBlue : AppTheme.borderLight,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected 
                  ? AppTheme.primaryBlue.withValues(alpha: 0.2) 
                  : Colors.black.withValues(alpha: 0.04),
              blurRadius: isSelected ? 12 : 4,
              offset: Offset(0, isSelected ? 4 : 2),  // FIXED: removed const
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected 
                    ? Colors.white.withValues(alpha: 0.2) 
                    : AppTheme.primaryBlue.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                size: 20,
                color: isSelected ? Colors.white : AppTheme.primaryBlue,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : AppTheme.textDark,
                    ),
                  ),
                  Text(
                    '$count ${title == 'Hiring' ? 'positions' : 'profiles'}',
                    style: TextStyle(
                      fontSize: 12,
                      color: isSelected 
                          ? Colors.white.withValues(alpha: 0.8) 
                          : AppTheme.textLight,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle_rounded,
                size: 18,
                color: Colors.white.withValues(alpha: 0.8),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildJobCard(Map<String, dynamic> job) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: job['isFeatured'] 
              ? AppTheme.primaryBlue.withValues(alpha: 0.3) 
              : AppTheme.borderLight.withValues(alpha: 0.5),
          width: job['isFeatured'] ? 2 : 1,
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
            // Navigate to job details
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Company Logo Container
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: (job['color'] as Color).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        job['logo'],
                        color: job['color'],
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            job['title'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textDark,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            job['company'],
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppTheme.textMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (job['isFeatured'])
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryBlue.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.star_rounded,
                              size: 12,
                              color: AppTheme.accentGold,
                            ),
                            SizedBox(width: 2),
                            Text(
                              'Featured',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.primaryBlue,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 10),
                // Job details row
                Wrap(
                  spacing: 16,
                  runSpacing: 4,
                  children: [
                    _buildInfoChip(Icons.work_outline_rounded, job['type']),
                    _buildInfoChip(Icons.location_on_rounded, job['location']),
                    _buildInfoChip(Icons.money_rounded, job['salary']),
                    // Show experience for job seekers
                    if (job['experience'] != null)
                      _buildInfoChip(Icons.history_rounded, job['experience']),
                  ],
                ),
                const SizedBox(height: 10),
                // Posted time and apply button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time_rounded,
                          size: 14,
                          color: AppTheme.textLight,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          job['posted'],
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppTheme.textLight,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: _isHiring
                            ? AppTheme.success.withValues(alpha: 0.1)
                            : AppTheme.primaryBlue.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        _isHiring ? 'Apply Now' : 'View Profile',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: _isHiring ? AppTheme.success : AppTheme.primaryBlue,
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

  Widget _buildInfoChip(IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 14,
          color: AppTheme.textLight,
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppTheme.textMedium,
          ),
        ),
      ],
    );
  }
}