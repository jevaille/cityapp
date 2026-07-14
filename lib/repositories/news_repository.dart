import '../models/news_article.dart';
import '../services/news_api_service.dart';

class NewsRepository {

  NewsRepository({NewsApiService? apiService})
      : _apiService = apiService ?? NewsApiService();
  final NewsApiService _apiService;

  /// Fetch news articles from the repository
  /// 
  /// This method acts as a single source of truth for news data.
  /// It handles the business logic of fetching news and can be extended
  /// with caching, local storage, or other data sources in the future.
  Future<List<NewsArticle>> fetchNews({int page = 1, int limit = 20}) async {
    try {
      return await _apiService.fetchNews(page: page, limit: limit);
    } catch (e) {
      // Return sample data as fallback when API fails
      // This ensures the app works even without a backend
      return _getSampleNews();
    }
  }

  /// Get sample news for fallback/demo purposes
  List<NewsArticle> _getSampleNews() {
    return [
      NewsArticle(
        id: 'sample-1',
        title: 'Young motorists continue illegal street racing in GenSan',
        summary: 'A barangay official confirmed that some young motorists continue conducting illegal motorcycle races along highways in General Santos City, despite warnings and police presence.',
        source: 'Brigada News',
        link: 'https://www.brigadanews.ph',
        pubDate: DateTime.now().subtract(const Duration(hours: 2)),
        content: 'A barangay official confirmed that some young motorists continue conducting illegal motorcycle races along highways in General Santos City, despite warnings and police presence. The local government is considering stricter penalties to deter these activities.',
        category: 'Crime & Safety',
        readingTime: '2 min read',
      ),
      NewsArticle(
        id: 'sample-2',
        title: 'Speed limit law set for activation in General Santos City',
        summary: 'The General Santos City government is set to activate the speed limit law to ensure road safety and prevent accidents, especially in school zones and busy intersections.',
        source: 'Brigada News',
        link: 'https://www.brigadanews.ph',
        pubDate: DateTime.now().subtract(const Duration(hours: 5)),
        content: 'The General Santos City government is set to activate the speed limit law to ensure road safety and prevent accidents, especially in school zones and busy intersections. The new law will impose fines ranging from 1,000 to 5,000 pesos depending on the violation.',
        category: 'Government',
        readingTime: '3 min read',
      ),
      NewsArticle(
        id: 'sample-3',
        title: 'GenSan underpass project criticized anew after repeated flooding',
        summary: 'The underpass project in General Santos City has been criticized again after it experienced flooding, raising concerns about its design and the safety of motorists.',
        source: 'Brigada News',
        link: 'https://www.brigadanews.ph',
        pubDate: DateTime.now().subtract(const Duration(days: 1)),
        content: 'The underpass project in General Santos City has been criticized again after it experienced flooding, raising concerns about its design and the safety of motorists. City engineers are now evaluating drainage improvements to address the recurring issue.',
        category: 'Infrastructure',
        readingTime: '4 min read',
      ),
      NewsArticle(
        id: 'sample-4',
        title: 'City launches new digital services for business permits',
        summary: 'General Santos City has launched an online portal for business permit applications and renewals to streamline the process and reduce processing time.',
        source: 'City Information Office',
        link: 'https://www.gensan.gov.ph',
        pubDate: DateTime.now().subtract(const Duration(days: 2)),
        content: 'General Santos City has launched an online portal for business permit applications and renewals to streamline the process and reduce processing time. The new system allows business owners to submit applications online, track status, and receive digital permits.',
        author: 'City Information Office',
        category: 'Government',
        readingTime: '3 min read',
      ),
      NewsArticle(
        id: 'sample-5',
        title: 'Health department conducts free medical mission in barangay',
        summary: 'The City Health Office conducted a free medical mission in Barangay Lagao, providing check-ups, medicines, and health education to residents.',
        source: 'City Health Office',
        link: 'https://www.gensan.gov.ph',
        pubDate: DateTime.now().subtract(const Duration(days: 3)),
        content: 'The City Health Office conducted a free medical mission in Barangay Lagao, providing check-ups, medicines, and health education to residents. Over 500 residents benefited from the program which included dental services, blood pressure monitoring, and free vitamins.',
        author: 'City Health Office',
        category: 'Health',
        readingTime: '2 min read',
      ),
    ];
  }

  /// Set the base URL for the API (useful for testing)
  void setBaseUrl(String baseUrl) {
    _apiService.setBaseUrl(baseUrl);
  }

  /// Set authentication token if needed
  void setAuthToken(String token) {
    _apiService.setAuthToken(token);
  }
}
