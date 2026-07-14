class NewsArticle {

  NewsArticle({
    required this.id,
    required this.title,
    required this.summary,
    required this.source,
    required this.link,
    required this.pubDate,
    this.image = '',
    this.content = '',
    this.author = '',
    this.category = 'General',
    this.readingTime = '',
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      id: json['id'] ?? json['link'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
      title: json['title'],
      summary: json['summary'],
      source: json['source'],
      link: json['link'],
      pubDate: DateTime.parse(json['pubDate']),
      image: json['image'] ?? json['imageUrl'] ?? '',
      content: json['content'] ?? '',
      author: json['author'] ?? '',
      category: json['category'] ?? 'General',
      readingTime: json['readingTime'] ?? '',
    );
  }
  final String id;
  final String title;
  final String summary;
  final String source;
  final String link;
  final DateTime pubDate;
  final String image;
  final String content;
  final String author;
  final String category;
  final String readingTime;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'summary': summary,
      'source': source,
      'link': link,
      'pubDate': pubDate.toIso8601String(),
      'imageUrl': image,
      'content': content,
      'author': author,
      'category': category,
      'readingTime': readingTime,
    };
  }

  NewsArticle copyWith({
    String? id,
    String? title,
    String? summary,
    String? source,
    String? link,
    DateTime? pubDate,
    String? image,
    String? content,
    String? author,
    String? category,
    String? readingTime,
  }) {
    return NewsArticle(
      id: id ?? this.id,
      title: title ?? this.title,
      summary: summary ?? this.summary,
      source: source ?? this.source,
      link: link ?? this.link,
      pubDate: pubDate ?? this.pubDate,
      image: image ?? this.image,
      content: content ?? this.content,
      author: author ?? this.author,
      category: category ?? this.category,
      readingTime: readingTime ?? this.readingTime,
    );
  }
}