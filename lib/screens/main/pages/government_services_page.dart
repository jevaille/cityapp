import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../app/theme.dart';
import '../../../models/government_service.dart';
import '../../../widgets/government_services/government_section.dart';
import '../../../widgets/government_services/search_bar_widget.dart';
import '../../../widgets/government_services/quick_access_chip.dart';

class GovernmentServicesPage extends StatefulWidget {
  const GovernmentServicesPage({super.key});

  @override
  State<GovernmentServicesPage> createState() => _GovernmentServicesPageState();
}

class _GovernmentServicesPageState extends State<GovernmentServicesPage> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'Most Used';

  // Tab selection: true = National, false = Local
  bool _showNationalServices = true;

  final List<String> _quickAccessFilters = [
    'Most Used',
    'Payments',
    'IDs',
    'Business',
    'Health',
    'Employment',
    'Civil Registry',
  ];

  List<GovernmentService> _filteredNationalServices = nationalGovernmentServices;
  List<GovernmentService> _filteredGensanServices = gensanGovernmentServices;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChangedListener);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChangedListener() {
    _performSearch();
  }

  void _onSearchChanged(String query) {
    _performSearch();
  }

  void _performSearch() {
    setState(() {
      final query = _searchController.text.toLowerCase();
      if (query.isEmpty) {
        _filteredNationalServices = nationalGovernmentServices;
        _filteredGensanServices = gensanGovernmentServices;
      } else {
        _filteredNationalServices = nationalGovernmentServices
            .where((service) =>
                service.title.toLowerCase().contains(query) ||
                service.subtitle.toLowerCase().contains(query))
            .toList();
        _filteredGensanServices = gensanGovernmentServices
            .where((service) =>
                service.title.toLowerCase().contains(query) ||
                service.subtitle.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  void _onFilterSelected(String filter) {
    HapticFeedback.selectionClick();
    setState(() {
      _selectedFilter = filter;
    });
  }

  void _onToggleSelected(bool showNational) {
    if (_showNationalServices == showNational) return;
    HapticFeedback.selectionClick();
    setState(() {
      _showNationalServices = showNational;
    });
  }

  void _onServiceTap(GovernmentService service) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening ${service.title}...'),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isEmpty = _showNationalServices
        ? _filteredNationalServices.isEmpty
        : _filteredGensanServices.isEmpty;

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Column(
          children: [
            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Search Bar
                    SearchBarWidget(
                      controller: _searchController,
                      onChanged: _onSearchChanged,
                    ),
                    const SizedBox(height: 18),
                    // Quick Access Chips
                    SizedBox(
                      height: 44,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _quickAccessFilters.length,
                        itemBuilder: (context, index) {
                          final filter = _quickAccessFilters[index];
                          return Padding(
                            padding: EdgeInsets.only(
                              right: index < _quickAccessFilters.length - 1 ? 10 : 0,
                            ),
                            child: QuickAccessChip(
                              label: filter,
                              isSelected: _selectedFilter == filter,
                              onTap: () => _onFilterSelected(filter),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Modern Card Toggle - National vs Local
                    _buildCardToggle(),
                    const SizedBox(height: 18),
                    // Service List based on selected toggle, with smooth crossfade
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 260),
                      switchInCurve: Curves.easeOut,
                      switchOutCurve: Curves.easeIn,
                      transitionBuilder: (child, animation) {
                        final slide = Tween<Offset>(
                          begin: const Offset(0, 0.03),
                          end: Offset.zero,
                        ).animate(animation);
                        return FadeTransition(
                          opacity: animation,
                          child: SlideTransition(position: slide, child: child),
                        );
                      },
                      child: isEmpty
                          ? _buildEmptyState(
                              key: const ValueKey('empty'),
                            )
                          : KeyedSubtree(
                              key: ValueKey(_showNationalServices),
                              child: _showNationalServices
                                  ? GovernmentSection(
                                      title: 'Philippine National Government Services',
                                      services: _filteredNationalServices,
                                      onServiceTap: _onServiceTap,
                                    )
                                  : GovernmentSection(
                                      title: 'General Santos City Government Services',
                                      services: _filteredGensanServices,
                                      onServiceTap: _onServiceTap,
                                    ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------
  // Modern Card Toggle - Government Style (Same as Jobs Page)
  // ---------------------------------------------------------------------
  Widget _buildCardToggle() {
    return Row(
      children: [
        Expanded(
          child: _buildToggleCard(
            icon: Icons.account_balance_rounded,
            title: 'National',
            count: _filteredNationalServices.length,
            isSelected: _showNationalServices,
            onTap: () => _onToggleSelected(true),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildToggleCard(
            icon: Icons.location_city_rounded,
            title: 'Local (GenSan)',
            count: _filteredGensanServices.length,
            isSelected: !_showNationalServices,
            onTap: () => _onToggleSelected(false),
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
              offset: Offset(0, isSelected ? 4 : 2),
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
                    '$count services',
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

  Widget _buildEmptyState({Key? key}) {
    return TweenAnimationBuilder<double>(
      key: key,
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, (1 - value) * 8),
            child: child,
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
        decoration: BoxDecoration(
          color: AppTheme.cardBg,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppTheme.borderLight.withValues(alpha: 0.5),
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: AppTheme.primaryBlueSurface,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.search_off_rounded,
                size: 48,
                color: AppTheme.primaryBlue,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Government services are currently unavailable.',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppTheme.textDark,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Try adjusting your search or filters.',
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.textLight,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}