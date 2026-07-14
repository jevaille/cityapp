import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/news_article.dart';

class BookmarkService {
  static const String _bookmarksKey = 'news_bookmarks';
  
  /// Get all bookmarked articles
  Future<List<NewsArticle>> getBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarksJson = prefs.getString(_bookmarksKey);
    
    if (bookmarksJson == null) {
      return [];
    }
    
    try {
      final List<dynamic> decoded = json.decode(bookmarksJson);
      return decoded.map((json) => NewsArticle.fromJson(json)).toList();
    } catch (e) {
      print('Error decoding bookmarks: $e');
      return [];
    }
  }
  
  /// Check if an article is bookmarked
  Future<bool> isBookmarked(String articleId) async {
    final bookmarks = await getBookmarks();
    return bookmarks.any((article) => article.id == articleId);
  }
  
  /// Add an article to bookmarks
  Future<void> addBookmark(NewsArticle article) async {
    final bookmarks = await getBookmarks();
    
    // Check if already bookmarked
    if (bookmarks.any((a) => a.id == article.id)) {
      return;
    }
    
    bookmarks.add(article);
    await _saveBookmarks(bookmarks);
  }
  
  /// Remove an article from bookmarks
  Future<void> removeBookmark(String articleId) async {
    final bookmarks = await getBookmarks();
    bookmarks.removeWhere((article) => article.id == articleId);
    await _saveBookmarks(bookmarks);
  }
  
  /// Toggle bookmark status
  Future<bool> toggleBookmark(NewsArticle article) async {
    final isBookmarked = await this.isBookmarked(article.id);
    
    if (isBookmarked) {
      await removeBookmark(article.id);
      return false;
    } else {
      await addBookmark(article);
      return true;
    }
  }
  
  /// Clear all bookmarks
  Future<void> clearBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_bookmarksKey);
  }
  
  /// Save bookmarks to SharedPreferences
  Future<void> _saveBookmarks(List<NewsArticle> bookmarks) async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarksJson = json.encode(bookmarks.map((a) => a.toJson()).toList());
    await prefs.setString(_bookmarksKey, bookmarksJson);
  }
}
