import 'package:flutter/foundation.dart';
import '../models/event.dart';
import '../services/events_service.dart';

class EventProvider extends ChangeNotifier {

  EventProvider() {
    _initializeEvents();
  }
  List<Event> _allEvents = [];
  List<Event> _filteredEvents = [];
  String _selectedCategory = 'All';
  bool _isLoading = false;
  String? _error;
  final EventsService _eventsService = EventsService();

  List<Event> get events => _filteredEvents;
  String get selectedCategory => _selectedCategory;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> _initializeEvents() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _allEvents = await _eventsService.fetchEvents();
      _filteredEvents = _allEvents;
      _error = null;
    } catch (e) {
      _error = 'Failed to load events: $e';
      _allEvents = [];
      _filteredEvents = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  void setCategory(String category) {
    _selectedCategory = category;
    _filterEvents();
    notifyListeners();
  }

  void _filterEvents() {
    if (_selectedCategory == 'All') {
      _filteredEvents = _allEvents;
    } else {
      _filteredEvents = _allEvents.where((event) => event.category == _selectedCategory).toList();
    }
  }

  List<String> getCategories() {
    final categories = <String>{'All'};
    for (var event in _allEvents) {
      categories.add(event.category);
    }
    return categories.toList();
  }
}
