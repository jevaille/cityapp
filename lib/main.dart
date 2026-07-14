import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/app.dart';
import 'providers/auth_provider.dart';
import 'providers/user_provider.dart';
import 'providers/news_provider.dart';
import 'providers/report_provider.dart';
import 'providers/notification_provider.dart';
import 'providers/event_provider.dart';
import 'services/api_service.dart';
import 'services/auth_service.dart';
import 'services/news_service.dart';
import 'services/report_service.dart';
import 'services/notification_service.dart';
import 'services/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final prefs = await SharedPreferences.getInstance();
  final storageService = StorageService(prefs);
  final apiService = ApiService();
  final authService = AuthService(apiService);
  final newsService = NewsService(apiService);
  final reportService = ReportService(apiService);
  final notificationService = NotificationService(apiService);
  
  final token = storageService.getUserToken();
  if (token != null) {
    apiService.setToken(token);
  }

  runApp(
    MultiProvider(
      providers: [
        // Services
        Provider<ApiService>.value(value: apiService),
        Provider<AuthService>.value(value: authService),
        Provider<StorageService>.value(value: storageService),
        Provider<NewsService>.value(value: newsService),
        Provider<ReportService>.value(value: reportService),
        Provider<NotificationService>.value(value: notificationService),
        
        // Providers
        ChangeNotifierProvider(create: (_) => AuthProvider(authService)),
        ChangeNotifierProvider(create: (_) => UserProvider(storageService)),
        ChangeNotifierProvider(create: (_) => NewsProvider()), // NewsProvider creates its own NewsRepository
        ChangeNotifierProvider(create: (_) => ReportProvider(reportService)),
        ChangeNotifierProvider(create: (_) => NotificationProvider(notificationService)),
        ChangeNotifierProvider(create: (_) => EventProvider()),
      ],
      child: const CityApp(),
    ),
  );
}