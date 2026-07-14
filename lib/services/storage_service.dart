import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../app/constants.dart';

class StorageService {

  StorageService(this._prefs);
  final SharedPreferences _prefs;

  Future<void> saveString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  String? getString(String key) {
    return _prefs.getString(key);
  }

  Future<void> saveBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  Future<void> saveInt(String key, int value) async {
    await _prefs.setInt(key, value);
  }

  int? getInt(String key) {
    return _prefs.getInt(key);
  }

  Future<void> saveDouble(String key, double value) async {
    await _prefs.setDouble(key, value);
  }

  double? getDouble(String key) {
    return _prefs.getDouble(key);
  }

  Future<void> saveList(String key, List<String> value) async {
    await _prefs.setStringList(key, value);
  }

  List<String>? getList(String key) {
    return _prefs.getStringList(key);
  }

  Future<void> saveMap(String key, Map<String, dynamic> value) async {
    await _prefs.setString(key, json.encode(value));
  }

  Map<String, dynamic>? getMap(String key) {
    final String? data = _prefs.getString(key);
    if (data != null) {
      return json.decode(data);
    }
    return null;
  }

  Future<void> remove(String key) async {
    await _prefs.remove(key);
  }

  Future<void> clear() async {
    await _prefs.clear();
  }

  Future<void> saveUserToken(String token) async {
    await saveString(AppConstants.userTokenKey, token);
  }

  String? getUserToken() {
    return getString(AppConstants.userTokenKey);
  }

  Future<void> saveUserId(String userId) async {
    await saveString(AppConstants.userIdKey, userId);
  }

  String? getUserId() {
    return getString(AppConstants.userIdKey);
  }

  Future<void> clearUserData() async {
    await remove(AppConstants.userTokenKey);
    await remove(AppConstants.userIdKey);
  }
}