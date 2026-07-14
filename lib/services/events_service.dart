import 'package:http/http.dart' as http;
import '../models/event.dart';

class EventsService {
  static const String _eventsUrl = 'https://allevents.in/general-santos/all';

  Future<List<Event>> fetchEvents() async {
    try {
      final response = await http.get(Uri.parse(_eventsUrl)).timeout(
        const Duration(seconds: 15),
      );

      if (response.statusCode == 200) {
        print('Successfully fetched events from AllEvents website');
        final parsedEvents = _parseEventsFromHtml(response.body);
        if (parsedEvents.isNotEmpty) {
          print('Parsed ${parsedEvents.length} events from website');
          return parsedEvents;
        }
      }
      print('Using mock events as fallback');
      return _getMockEvents();
    } catch (e) {
      print('Error fetching events: $e');
      return _getMockEvents(); // Fallback to mock data
    }
  }

  List<Event> _parseEventsFromHtml(String html) {
    try {
      final events = <Event>[];
      final eventIdCounter = <String, int>{};

      // Look for event containers in the HTML
      // AllEvents typically uses divs with event data in data attributes or specific classes
      final eventPattern = RegExp(
        r'<div[^>]*class="[^"]*event[^"]*"[^>]*>.*?</div>',
        caseSensitive: false,
        dotAll: true,
      );

      final matches = eventPattern.allMatches(html);
      
      for (final match in matches.take(12)) {
        // Limit to 12 events
        final eventHtml = match.group(0) ?? '';

        // Extract title
        final titleMatch = RegExp(r'<h[1-6][^>]*>([^<]+)</h[1-6]>').firstMatch(eventHtml);
        final title = titleMatch?.group(1)?.trim() ?? 'Untitled Event';

        // Extract date
        final dateMatch = RegExp(
          r'((?:Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)[a-z]* \d{1,2}|today|tomorrow)',
          caseSensitive: false,
        ).firstMatch(eventHtml);
        final dateStr = dateMatch?.group(0) ?? '';

        // Extract location
        final locationMatch = RegExp(
          r'(?:location|venue|at)[:\s]+([^<,\n]+)',
          caseSensitive: false,
        ).firstMatch(eventHtml);
        final location = locationMatch?.group(1)?.trim() ?? 'General Santos City';

        // Extract image URL
        final imgMatch = RegExp(r'<img[^>]*src="([^"]+)"').firstMatch(eventHtml);
        final imageUrl = imgMatch?.group(1) ?? _getDefaultImage(_categorizeEvent(title));

        // Parse date
        final startTime = _parseEventDate(dateStr);

        final event = Event(
          id: 'event_${title.hashCode}_${eventIdCounter.putIfAbsent(title, () => 0)}',
          title: title,
          description: 'Event in General Santos',
          location: location,
          imageUrl: imageUrl,
          startTime: startTime,
          endTime: startTime.add(const Duration(hours: 3)),
          category: _categorizeEvent(title),
          maxAttendees: 500,
          currentAttendees: (200 + (title.hashCode % 300)),
        );
        
        if (title != 'Untitled Event') {
          events.add(event);
          eventIdCounter[title] = eventIdCounter[title]! + 1;
        }
      }

      return events;
    } catch (e) {
      print('Error parsing HTML: $e');
      return [];
    }
  }

  DateTime _parseEventDate(String dateStr) {
    try {
      final now = DateTime.now();
      
      if (dateStr.toLowerCase().contains('today')) {
        return now;
      }
      if (dateStr.toLowerCase().contains('tomorrow')) {
        return now.add(const Duration(days: 1));
      }

      // Parse month day format like "Jul 15"
      final monthDayMatch = RegExp(r'(\w+)\s+(\d{1,2})').firstMatch(dateStr);
      if (monthDayMatch != null) {
        final monthStr = (monthDayMatch.group(1) ?? '').toLowerCase();
        final dayStr = monthDayMatch.group(2) ?? '1';
        
        final months = {
          'jan': 1, 'feb': 2, 'mar': 3, 'apr': 4, 'may': 5, 'jun': 6,
          'jul': 7, 'aug': 8, 'sep': 9, 'oct': 10, 'nov': 11, 'dec': 12
        };
        
        final monthKey = monthStr.substring(0, 3);
        final month = months[monthKey] ?? now.month;
        final day = int.tryParse(dayStr) ?? now.day;
        
        var year = now.year;
        if (month < now.month || (month == now.month && day < now.day)) {
          year += 1;
        }
        
        return DateTime(year, month, day);
      }

      final dayOffset = (dateStr.hashCode % 60).abs();
      return now.add(Duration(days: dayOffset));
    } catch (e) {
      return DateTime.now().add(const Duration(days: 1));
    }
  }

  String _getDefaultImage(String category) {
    switch (category.toLowerCase()) {
      case 'concert':
        return 'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=500&h=300&fit=crop';
      case 'sports':
        return 'https://images.unsplash.com/photo-1461896836934-ffe607ba8211?w=500&h=300&fit=crop';
      case 'education':
        return 'https://images.unsplash.com/photo-1552664730-d307ca884978?w=500&h=300&fit=crop';
      case 'government':
        return 'https://images.unsplash.com/photo-1552664730-d307ca884978?w=500&h=300&fit=crop';
      case 'community':
        return 'https://images.unsplash.com/photo-1559027615-cd2628902d4a?w=500&h=300&fit=crop';
      default:
        return 'https://images.unsplash.com/photo-1540575467063-178f50902556?w=500&h=300&fit=crop';
    }
  }

  String _categorizeEvent(String title) {
    final lowerTitle = title.toLowerCase();
    if (lowerTitle.contains('concert') || 
        lowerTitle.contains('music') || 
        lowerTitle.contains('festival') ||
        lowerTitle.contains('band') ||
        lowerTitle.contains('show')) {
      return 'Concert';
    } else if (lowerTitle.contains('marathon') || 
               lowerTitle.contains('run') || 
               lowerTitle.contains('sports') ||
               lowerTitle.contains('game') ||
               lowerTitle.contains('tournament')) {
      return 'Sports';
    } else if (lowerTitle.contains('workshop') || 
               lowerTitle.contains('course') || 
               lowerTitle.contains('training') ||
               lowerTitle.contains('seminar') ||
               lowerTitle.contains('cooking')) {
      return 'Education';
    } else if (lowerTitle.contains('government') || 
               lowerTitle.contains('council') ||
               lowerTitle.contains('meeting') ||
               lowerTitle.contains('meeting')) {
      return 'Government';
    } else if (lowerTitle.contains('community') || 
               lowerTitle.contains('clean') ||
               lowerTitle.contains('volunteer')) {
      return 'Community';
    }
    return 'Community';
  }

  List<Event> _getMockEvents() {
    return [
      Event(
        id: '1',
        title: 'MUSIKATUNA 2025',
        description: 'Live music festival with various artists',
        location: 'Pioneer Ave, General Santos City',
        imageUrl: 'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=500&h=300&fit=crop',
        startTime: DateTime.now().add(const Duration(days: 30)),
        endTime: DateTime.now().add(const Duration(days: 30, hours: 4)),
        category: 'Concert',
        maxAttendees: 5000,
        currentAttendees: 2400,
      ),
      Event(
        id: '2',
        title: 'KCC Marathon Run',
        description: 'Join us for a community marathon event',
        location: 'KCC Veranza, General Santos City',
        imageUrl: 'https://images.unsplash.com/photo-1461896836934-ffe607ba8211?w=500&h=300&fit=crop',
        startTime: DateTime.now().add(const Duration(days: 20)),
        endTime: DateTime.now().add(const Duration(days: 20, hours: 3)),
        category: 'Sports',
        maxAttendees: 1000,
        currentAttendees: 650,
      ),
      Event(
        id: '3',
        title: 'Cooking Workshop',
        description: 'Learn traditional and modern cooking techniques',
        location: 'Aparente St., General Santos City',
        imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=500&h=300&fit=crop',
        startTime: DateTime.now().add(const Duration(days: 5)),
        endTime: DateTime.now().add(const Duration(days: 5, hours: 2)),
        category: 'Education',
        maxAttendees: 50,
        currentAttendees: 42,
      ),
      Event(
        id: '4',
        title: 'City Council Meeting',
        description: 'Monthly city council meeting with public participation',
        location: 'City Hall, General Santos City',
        imageUrl: 'https://images.unsplash.com/photo-1552664730-d307ca884978?w=500&h=300&fit=crop',
        startTime: DateTime.now().add(const Duration(days: 10)),
        endTime: DateTime.now().add(const Duration(days: 10, hours: 2)),
        category: 'Government',
        maxAttendees: 300,
        currentAttendees: 285,
      ),
      Event(
        id: '5',
        title: 'Community Clean-Up',
        description: 'Help keep our city clean and green',
        location: 'City Park, General Santos City',
        imageUrl: 'https://images.unsplash.com/photo-1559027615-cd2628902d4a?w=500&h=300&fit=crop',
        startTime: DateTime.now().add(const Duration(days: 7)),
        endTime: DateTime.now().add(const Duration(days: 7, hours: 3)),
        category: 'Community',
        maxAttendees: 200,
        currentAttendees: 128,
      ),
      Event(
        id: '6',
        title: 'Art Exhibition',
        description: 'Showcase of local and international artists',
        location: 'Arts Center, General Santos City',
        imageUrl: 'https://images.unsplash.com/photo-1575180888529-95d266b4b5cb?w=500&h=300&fit=crop',
        startTime: DateTime.now().add(const Duration(days: 15)),
        endTime: DateTime.now().add(const Duration(days: 22)),
        category: 'Education',
        maxAttendees: 500,
        currentAttendees: 342,
      ),
    ];
  }
}
