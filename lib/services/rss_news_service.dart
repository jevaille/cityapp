import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';
import '../models/news_article.dart';

class RssNewsService {
  // RSS Feed Sources for GenSan News (all free)
  // Priority order: Philstar, Google News, PIA, LGU, Brigada, SunStar
  static const Map<String, String> _feedSources = {
    'Philstar': 'https://www.philstar.com/rss/headlines/nation',
    'Google News': 'https://news.google.com/rss/search?q=General+Santos+City&hl=en-PH&gl=PH&ceid=PH:en',
    'PIA Region 12': 'https://pia.gov.ph/feed/regions/region-12',
    'Brigada News': 'https://www.brigadanews.ph/category/local-news/mindanao/gensan/feed',
    'SunStar General Santos': 'https://www.sunstar.com.ph/rss/general-santos',
  };

  /// Fetch news from all RSS feeds
  Future<List<NewsArticle>> fetchGenSanNews() async {
    List<NewsArticle> allArticles = [];
    
    for (var entry in _feedSources.entries) {
      try {
        final articles = await _fetchFromFeed(entry.value, entry.key);
        allArticles.addAll(articles);
        print('✅ Fetched ${articles.length} articles from ${entry.key}');
      } catch (e) {
        print('❌ Error fetching from ${entry.key}: $e');
      }
    }
    
    // Sort by date (newest first)
    allArticles.sort((a, b) => b.pubDate.compareTo(a.pubDate));
    
    // Remove duplicates (by URL/link)
    final uniqueArticles = <String, NewsArticle>{};
    for (var article in allArticles) {
      if (!uniqueArticles.containsKey(article.link)) {
        uniqueArticles[article.link] = article;
      }
    }
    
    return uniqueArticles.values.toList();
  }

  /// Fetch and parse a single RSS feed
  Future<List<NewsArticle>> _fetchFromFeed(String feedUrl, String sourceName) async {
    try {
      // Fetch the RSS feed
      final response = await http.get(
        Uri.parse(feedUrl),
        headers: {
          'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
        },
      );
      
      if (response.statusCode != 200) {
        throw Exception('Failed to load feed: ${response.statusCode}');
      }

      // Parse the XML
      final document = XmlDocument.parse(response.body);
      
      // Find all item elements
      final items = document.findAllElements('item');
      
      List<NewsArticle> articles = [];
      
      for (var item in items) {
        try {
          // Extract data from RSS item
          final title = item.findElements('title').firstOrNull?.text ?? 'No Title';
          final link = item.findElements('link').firstOrNull?.text ?? '';
          final pubDate = item.findElements('pubDate').firstOrNull?.text ?? '';
          final description = item.findElements('description').firstOrNull?.text ?? '';
          
          // Try to get full content
          String content = '';
          final encodedContent = item.findElements('content:encoded').firstOrNull;
          if (encodedContent != null) {
            content = encodedContent.text;
          } else if (item.findElements('encoded').firstOrNull != null) {
            content = item.findElements('encoded').firstOrNull!.text;
          } else {
            content = description;
          }
          
          // Extract image from content
          String image = _extractImage(content);
          
          // Clean up the summary
          String summary = _cleanHtml(content.isNotEmpty ? content : description);
          if (summary.length > 300) {
            summary = '${summary.substring(0, 300)}...';
          }
          
          // Parse date
          DateTime date = DateTime.now();
          try {
            date = DateTime.parse(pubDate);
          } catch (e) {
            try {
              date = _parseRssDate(pubDate);
            } catch (e2) {
              // Keep current date
            }
          }
          
          articles.add(NewsArticle(
            id: link.trim(),
            title: title.trim(),
            summary: summary.trim(),
            source: sourceName,
            link: link.trim(),
            pubDate: date,
            image: image,
            content: content.isNotEmpty ? content : description,
            category: _categorizeArticle(title, sourceName),
          ));
        } catch (e) {
          print('⚠️ Error parsing article: $e');
        }
      }
      
      return articles;
    } catch (e) {
      print('❌ Error fetching feed: $e');
      return [];
    }
  }

  /// Clean HTML tags from text
  String _cleanHtml(String html) {
    String text = html.replaceAll(RegExp(r'<[^>]*>'), ' ');
    text = text.replaceAll(RegExp(r'&[^;]+;'), ' ');
    text = text.replaceAll(RegExp(r'\s+'), ' ').trim();
    return text;
  }

  /// Extract image URL from HTML content
  String _extractImage(String html) {
    final match = RegExp(r'<img[^>]+src="([^">]+)"').firstMatch(html);
    if (match != null) {
      String imageUrl = match.group(1) ?? '';
      if (imageUrl.startsWith('http')) {
        return imageUrl;
      }
    }
    return '';
  }

  /// Parse RSS date format
  DateTime _parseRssDate(String dateStr) {
    final months = {
      'Jan': 1, 'Feb': 2, 'Mar': 3, 'Apr': 4, 'May': 5, 'Jun': 6,
      'Jul': 7, 'Aug': 8, 'Sep': 9, 'Oct': 10, 'Nov': 11, 'Dec': 12
    };
    
    try {
      final parts = dateStr.split(' ');
      if (parts.length >= 5) {
        final day = int.parse(parts[1]);
        final month = months[parts[2]] ?? 1;
        final year = int.parse(parts[3]);
        final timeParts = parts[4].split(':');
        final hour = int.parse(timeParts[0]);
        final minute = int.parse(timeParts[1]);
        final second = int.parse(timeParts[2]);
        return DateTime(year, month, day, hour, minute, second);
      }
    } catch (e) {
      // Fallback
    }
    return DateTime.now();
  }

  /// Categorize article based on title and source
  String _categorizeArticle(String title, String source) {
    final lowerTitle = title.toLowerCase();
    
    if (lowerTitle.contains('government') || lowerTitle.contains('city') || 
        lowerTitle.contains('mayor') || lowerTitle.contains('council') ||
        lowerTitle.contains('official') || lowerTitle.contains('lgu')) {
      return 'Government';
    }
    if (lowerTitle.contains('business') || lowerTitle.contains('economy') ||
        lowerTitle.contains('investment') || lowerTitle.contains('trade')) {
      return 'Business';
    }
    if (lowerTitle.contains('crime') || lowerTitle.contains('police') ||
        lowerTitle.contains('accident') || lowerTitle.contains('safety')) {
      return 'Crime & Safety';
    }
    if (lowerTitle.contains('health') || lowerTitle.contains('hospital') ||
        lowerTitle.contains('medical') || lowerTitle.contains('vaccine')) {
      return 'Health';
    }
    if (lowerTitle.contains('education') || lowerTitle.contains('school') ||
        lowerTitle.contains('university') || lowerTitle.contains('student')) {
      return 'Education';
    }
    if (lowerTitle.contains('infrastructure') || lowerTitle.contains('road') ||
        lowerTitle.contains('bridge') || lowerTitle.contains('project') ||
        lowerTitle.contains('construction')) {
      return 'Infrastructure';
    }
    if (lowerTitle.contains('weather') || lowerTitle.contains('flood') ||
        lowerTitle.contains('storm') || lowerTitle.contains('rain')) {
      return 'Weather';
    }
    
    // Default category based on source
    if (source.contains('PIA')) return 'Government';
    if (source.contains('Philstar')) return 'National';
    if (source.contains('Google')) return 'News';
    
    return 'General';
  }
}