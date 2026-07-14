import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/theme.dart';
import '../../../widgets/common/page_background.dart';
import '../../../widgets/event_card_with_image.dart';
import '../../../providers/event_provider.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  String _selectedDateFilter = 'All';
  final List<String> _dateFilters = [
    'All',
    'This Week',
    'This Month',
    'Next Month'
  ];

  List<dynamic> _getFilteredEvents(List<dynamic> allEvents) {
    if (_selectedDateFilter == 'All') {
      return allEvents;
    }

    final now = DateTime.now();
    return allEvents.where((event) {
      final eventDate = event.startTime as DateTime;

      switch (_selectedDateFilter) {
        case 'This Week':
          final weekEnd = now.add(const Duration(days: 7));
          return eventDate.isAfter(now) && eventDate.isBefore(weekEnd);
        case 'This Month':
          final monthEnd = DateTime(now.year, now.month + 1);
          return eventDate.isAfter(now) && eventDate.isBefore(monthEnd);
        case 'Next Month':
          final nextMonthStart = DateTime(now.year, now.month + 1);
          final nextMonthEnd = DateTime(now.year, now.month + 2);
          return eventDate.isAfter(nextMonthStart) &&
              eventDate.isBefore(nextMonthEnd);
        default:
          return true;
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EventProvider>(
      builder: (context, eventProvider, _) {
        final filteredEvents = _getFilteredEvents(eventProvider.events);

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
                      'Events',
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
                            'Upcoming events and activities in your city',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppTheme.textLight,
                            ),
                          ),
                        ),
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
                            '${filteredEvents.length} Events',
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
              // Date Filter Chips
              Container(
                height: 44,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _dateFilters.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    final filter = _dateFilters[index];
                    final isSelected = _selectedDateFilter == filter;
                    return FilterChip(
                      label: Text(
                        filter,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.w500,
                          color:
                              isSelected ? Colors.white : AppTheme.textMedium,
                        ),
                      ),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          _selectedDateFilter = filter;
                        });
                      },
                      backgroundColor: Colors.white,
                      selectedColor: AppTheme.primaryBlue,
                      side: BorderSide(
                        color: isSelected
                            ? AppTheme.primaryBlue
                            : AppTheme.borderLight,
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    );
                  },
                ),
              ),
              // Event List
              if (eventProvider.isLoading)
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircularProgressIndicator(),
                        const SizedBox(height: 16),
                        Text(
                          'Loading events from General Santos...',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppTheme.textMedium.withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else if (eventProvider.error != null)
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline_rounded,
                          size: 48,
                          color: Colors.red.withValues(alpha: 0.3),
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Text(
                            eventProvider.error!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: AppTheme.textMedium.withValues(alpha: 0.6),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else if (filteredEvents.isEmpty)
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.event_note_rounded,
                          size: 56,
                          color: AppTheme.textMedium.withValues(alpha: 0.3),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No events found',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textMedium.withValues(alpha: 0.6),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Try changing the date filter',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppTheme.textMedium.withValues(alpha: 0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final width = constraints.maxWidth;
                      final crossAxisCount = width >= 1180
                          ? 3
                          : width >= 760
                              ? 2
                              : 1;
                      final horizontalPadding = width >= 760 ? 52.0 : 16.0;

                      return SingleChildScrollView(
                        padding: EdgeInsets.fromLTRB(
                          horizontalPadding,
                          12,
                          horizontalPadding,
                          28,
                        ),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            crossAxisSpacing: 32,
                            mainAxisSpacing: 30,
                            mainAxisExtent: 286,
                          ),
                          itemCount: filteredEvents.length,
                          itemBuilder: (context, index) {
                            final event = filteredEvents[index];
                            return EventCardWithImage(
                              title: event.title,
                              location: event.location,
                              imageUrl: event.imageUrl,
                              startTime: event.startTime,
                              category: event.category,
                              currentAttendees: event.currentAttendees,
                              maxAttendees: event.maxAttendees,
                              onTap: () {
                                // Navigate to event details
                              },
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
