import 'api_service.dart';
import '../models/notification.dart';

class NotificationService {

  NotificationService(this._apiService);
  final ApiService _apiService;

  Future<List<AppNotification>> getNotifications() async {
    try {
      final response = await _apiService.get('/notifications');
      final List<dynamic> notificationsList = response['data'];
      return notificationsList
          .map((json) => AppNotification.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to load notifications: $e');
    }
  }

  Future<Map<String, dynamic>> markAsRead(String id) async {
    try {
      final response = await _apiService.put(
        '/notifications/$id/read',
      );
      return {
        'success': true,
        'message': response['message'],
      };
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> markAllAsRead() async {
    try {
      final response = await _apiService.put(
        '/notifications/read-all',
      );
      return {
        'success': true,
        'message': response['message'],
      };
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<int> getUnreadCount() async {
    try {
      final response = await _apiService.get('/notifications/unread-count');
      return response['count'];
    } catch (e) {
      throw Exception('Failed to get unread count: $e');
    }
  }
}