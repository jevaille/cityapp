import 'package:dio/dio.dart';
import '../models/news_article.dart';

class NewsApiService {

  NewsApiService({String? baseUrl})
      : _dio = Dio(BaseOptions(
          baseUrl: baseUrl ?? _baseUrl,
          connectTimeout: _timeout,
          receiveTimeout: _timeout,
          sendTimeout: _timeout,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ));
  final Dio _dio;
  static const String _baseUrl = 'https://your-api-domain.com'; // Replace with actual API base URL
  static const String _newsEndpoint = '/api/news';
  static const Duration _timeout = Duration(seconds: 30);

  /// Fetch news articles from the backend API
  /// 
  /// Supports:
  /// - Loading with timeout
  /// - Retry once on failure
  /// - Error handling
  /// - JSON parsing
  Future<List<NewsArticle>> fetchNews({int page = 1, int limit = 20}) async {
    try {
      final response = await _dio.get(
        _newsEndpoint,
        queryParameters: {
          'page': page,
          'limit': limit,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        
        if (data is Map<String, dynamic> && data.containsKey('articles')) {
          final articlesList = data['articles'] as List;
          return articlesList
              .map((json) => NewsArticle.fromJson(json as Map<String, dynamic>))
              .toList();
        } else if (data is List) {
          return data
              .map((json) => NewsArticle.fromJson(json as Map<String, dynamic>))
              .toList();
        } else {
          throw Exception('Invalid response format');
        }
      } else {
        throw Exception('Failed to load news: ${response.statusCode}');
      }
    } on DioException catch (e) {
      // Retry once on DioException
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionError) {
        try {
          final response = await _dio.get(
            _newsEndpoint,
            queryParameters: {
              'page': page,
              'limit': limit,
            },
          );

          if (response.statusCode == 200) {
            final data = response.data;
            
            if (data is Map<String, dynamic> && data.containsKey('articles')) {
              final articlesList = data['articles'] as List;
              return articlesList
                  .map((json) => NewsArticle.fromJson(json as Map<String, dynamic>))
                  .toList();
            } else if (data is List) {
              return data
                  .map((json) => NewsArticle.fromJson(json as Map<String, dynamic>))
                  .toList();
            }
          }
        } catch (retryError) {
          throw Exception('Network error: ${e.message}');
        }
      }
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Failed to load news: $e');
    }
  }

  /// Set the base URL for the API (useful for testing or different environments)
  void setBaseUrl(String baseUrl) {
    _dio.options.baseUrl = baseUrl;
  }

  /// Add authentication token if needed
  void setAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }
}
