import 'package:flutter/material.dart';
import '../models/notification.dart';
import '../services/notification_service.dart';

class NotificationProvider extends ChangeNotifier {

  NotificationProvider(this._notificationService);
  final NotificationService _notificationService;
  List<AppNotification> _notifications = [];
  bool _isLoading = false;
  int _unreadCount = 0;

  List<AppNotification> get notifications => _notifications;
  bool get isLoading => _isLoading;
  int get unreadCount => _unreadCount;

  Future<void> loadNotifications() async {
    _isLoading = true;
    notifyListeners();

    try {
      _notifications = await _notificationService.getNotifications();
      _isLoading = false;
      await loadUnreadCount();
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      throw Exception('Failed to load notifications: $e');
    }
  }

  Future<void> loadUnreadCount() async {
    try {
      _unreadCount = await _notificationService.getUnreadCount();
      notifyListeners();
    } catch (e) {
      _unreadCount = 0;
      notifyListeners();
    }
  }

  Future<bool> markAsRead(String id) async {
    try {
      final result = await _notificationService.markAsRead(id);
      if (result['success']) {
        await loadNotifications();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> markAllAsRead() async {
    try {
      final result = await _notificationService.markAllAsRead();
      if (result['success']) {
        await loadNotifications();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}