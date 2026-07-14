import 'package:flutter/material.dart';
import '../../app/theme.dart';  // Changed to relative import

class JobPortalScreen extends StatefulWidget {
  const JobPortalScreen({super.key});

  @override
  State<JobPortalScreen> createState() => _JobPortalScreenState();
}

class _JobPortalScreenState extends State<JobPortalScreen> {
  List<Map<String, dynamic>> jobs = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadJobs();
  }

  Future<void> _loadJobs() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      jobs = [
        {
          'title': 'Senior Flutter Developer',
          'company': 'Tech Corp Inc.',
          'location': 'San Francisco, CA',
          'type': 'Full-time',
          'salary': '\$90,000 - \$120,000',
          'posted': '2 days ago',
        },
        {
          'title': 'City Planner',
          'company': 'City Government',
          'location': 'City Hall',
          'type': 'Full-time',
          'salary': '\$65,000 - \$85,000',
          'posted': '5 days ago',
        },
        {
          'title': 'Public Works Engineer',
          'company': 'Department of Public Works',
          'location': 'City Center',
          'type': 'Full-time',
          'salary': '\$70,000 - \$90,000',
          'posted': '1 week ago',
        },
        {
          'title': 'Community Outreach Coordinator',
          'company': 'Community Services',
          'location': 'Multiple Locations',
          'type': 'Part-time',
          'salary': '\$40,000 - \$55,000',
          'posted': '2 weeks ago',
        },
        {
          'title': 'IT Support Specialist',
          'company': 'City IT Department',
          'location': 'City Hall',
          'type': 'Full-time',
          'salary': '\$55,000 - \$70,000',
          'posted': '3 weeks ago',
        },
      ];
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text(
          'Job Portal',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.bookmark_border),
            onPressed: () {},
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Find Your Next Opportunity',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textDark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Browse job listings from the city and local employers',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppTheme.textMedium,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: ListView.builder(
                      itemCount: jobs.length,
                      itemBuilder: (context, index) {
                        final job = jobs[index];
                        return _buildJobCard(
                          job['title']!,
                          job['company']!,
                          job['location']!,
                          job['type']!,
                          job['salary']!,
                          job['posted']!,
                          () {
                            // Navigate to job details
                            Navigator.pushNamed(context, '/job-details');
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Navigate to my applications
          Navigator.pushNamed(context, '/my-applications');
        },
        icon: const Icon(Icons.list_alt),
        label: const Text('My Applications'),
        backgroundColor: AppTheme.primaryBlue,
        foregroundColor: Colors.white,
      ),
    );
  }

  Widget _buildJobCard(
    String title,
    String company,
    String location,
    String type,
    String salary,
    String posted,
    VoidCallback onTap,
  ) {
    // Determine job type color
    Color typeColor;
    if (type == 'Full-time') {
      typeColor = Colors.green;
    } else if (type == 'Part-time') {
      typeColor = Colors.orange;
    } else {
      typeColor = Colors.blue;
    }

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: AppTheme.borderLight.withValues(alpha: 0.5),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Company Logo Placeholder
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryBlue.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.business,
                      color: AppTheme.primaryBlue,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textDark,
                          ),
                        ),
                        Text(
                          company,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppTheme.textMedium,
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
                      borderRadius: BorderRadius.circular(12),
                      color: typeColor.withValues(alpha: 0.1),
                    ),
                    child: Text(
                      type,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: typeColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    size: 14,
                    color: AppTheme.textLight,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    location,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.textLight,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Icon(
                    Icons.attach_money,
                    size: 14,
                    color: AppTheme.textLight,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    salary,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.textLight,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    posted,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.textLight,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}