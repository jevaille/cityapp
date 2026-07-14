import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/storage_service.dart';

class UserProvider extends ChangeNotifier {

  UserProvider(this._storageService);
  final StorageService _storageService;
  User? _currentUser;

  User? get currentUser => _currentUser;

  void setUser(User user) {
    _currentUser = user;
    notifyListeners();
  }

  Future<void> updateUser(User user) async {
    _currentUser = user;
    notifyListeners();
  }

  Future<void> clearUser() async {
    _currentUser = null;
    await _storageService.clearUserData();
    notifyListeners();
  }
}