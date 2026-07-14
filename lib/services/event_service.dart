import 'api_service.dart';
import '../models/event.dart';

class EventService {

  EventService(this._apiService);
  final ApiService _apiService;

  Future<List<Event>> getEvents() async {
    try {
      final response = await _apiService.get('/events');
      final List<dynamic> eventsList = response['data'];
      return eventsList.map((json) => Event.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load events: $e');
    }
  }

  Future<Event> getEventById(String id) async {
    try {
      final response = await _apiService.get('/events/$id');
      return Event.fromJson(response['data']);
    } catch (e) {
      throw Exception('Failed to load event: $e');
    }
  }

  Future<List<Event>> getUpcomingEvents() async {
    try {
      final response = await _apiService.get('/events/upcoming');
      final List<dynamic> eventsList = response['data'];
      return eventsList.map((json) => Event.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load upcoming events: $e');
    }
  }

  Future<Map<String, dynamic>> registerForEvent(String eventId) async {
    try {
      final response = await _apiService.post(
        '/events/$eventId/register',
      );
      return {
        'success': true,
        'message': response['message'],
      };
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }
}