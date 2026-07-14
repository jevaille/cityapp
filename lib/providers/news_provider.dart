import 'package:flutter/material.dart';
import '../models/news_article.dart';
import '../repositories/news_repository.dart';
import '../services/bookmark_service.dart';

class NewsProvider extends ChangeNotifier {

  NewsProvider({
    NewsRepository? newsRepository,
    BookmarkService? bookmarkService,
  })  : _newsRepository = newsRepository ?? NewsRepository(),
        _bookmarkService = bookmarkService ?? BookmarkService();
  final NewsRepository _newsRepository;
  final BookmarkService _bookmarkService;

  // State
  List<NewsArticle> _articles = [];
  List<NewsArticle> _bookmarks = [];
  bool _isLoading = false;
  bool _isRefreshing = false;
  String? _errorMessage;
  int _currentPage = 1;
  bool _hasMore = true;

  // Getters
  List<NewsArticle> get articles => _articles;
  List<NewsArticle> get bookmarks => _bookmarks;
  bool get isLoading => _isLoading;
  bool get isRefreshing => _isRefreshing;
  String? get errorMessage => _errorMessage;
  bool get hasMore => _hasMore;

  /// Load initial news
  Future<void> loadNews() async {
    _isLoading = true;
    _errorMessage = null;
    _currentPage = 1;
    _hasMore = true;
    notifyListeners();

    try {
      _articles = await _newsRepository.fetchNews();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Refresh news (pull-to-refresh)
  Future<void> refreshNews() async {
    _isRefreshing = true;
    _errorMessage = null;
    _currentPage = 1;
    _hasMore = true;
    notifyListeners();

    try {
      _articles = await _newsRepository.fetchNews();
      _isRefreshing = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isRefreshing = false;
      notifyListeners();
    }
  }

  /// Load more news (infinite scroll)
  Future<void> loadMore() async {
    if (_isLoading || _isRefreshing || !_hasMore) return;

    _isLoading = true;
    notifyListeners();

    try {
      _currentPage++;
      final newArticles = await _newsRepository.fetchNews(
        page: _currentPage,
      );

      if (newArticles.isEmpty) {
        _hasMore = false;
      } else {
        _articles.addAll(newArticles);
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _currentPage--; // Revert page increment on error
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Get a single news article by ID
  NewsArticle? getNewsById(String id) {
    try {
      return _articles.firstWhere((article) => article.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Retry loading news after error
  Future<void> retry() async {
    await loadNews();
  }

  // Bookmark methods
  Future<void> loadBookmarks() async {
    _bookmarks = await _bookmarkService.getBookmarks();
    notifyListeners();
  }

  Future<bool> isBookmarked(String articleId) async {
    return await _bookmarkService.isBookmarked(articleId);
  }

  Future<bool> toggleBookmark(NewsArticle article) async {
    final isBookmarked = await _bookmarkService.toggleBookmark(article);
    await loadBookmarks();
    return isBookmarked;
  }

  Future<void> removeBookmark(String articleId) async {
    await _bookmarkService.removeBookmark(articleId);
    await loadBookmarks();
  }

  /// Set API base URL (useful for testing)
  void setApiBaseUrl(String baseUrl) {
    _newsRepository.setBaseUrl(baseUrl);
  }

  /// Set authentication token
  void setAuthToken(String token) {
    _newsRepository.setAuthToken(token);
  }
}