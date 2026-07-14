import 'api_service.dart';
import '../models/news.dart';

class NewsService {

  NewsService(this._apiService);
  final ApiService _apiService;

  Future<List<News>> getNews() async {
    try {
      final response = await _apiService.get('/news');
      final List<dynamic> newsList = response['data'];
      return newsList.map((json) => News.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load news: $e');
    }
  }

  Future<News> getNewsById(String id) async {
    try {
      final response = await _apiService.get('/news/$id');
      return News.fromJson(response['data']);
    } catch (e) {
      throw Exception('Failed to load news: $e');
    }
  }

  Future<List<News>> getNewsByCategory(String category) async {
    try {
      final response = await _apiService.get('/news/category/$category');
      final List<dynamic> newsList = response['data'];
      return newsList.map((json) => News.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load news: $e');
    }
  }
}