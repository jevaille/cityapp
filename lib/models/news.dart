class News {

  News({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    required this.imageUrl,
    required this.publishedAt,
    required this.author,
    required this.views,
    required this.tags,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      category: json['category'],
      imageUrl: json['imageUrl'],
      publishedAt: DateTime.parse(json['publishedAt']),
      author: json['author'],
      views: json['views'],
      tags: List<String>.from(json['tags']),
    );
  }
  final String id;
  final String title;
  final String content;
  final String category;
  final String imageUrl;
  final DateTime publishedAt;
  final String author;
  final int views;
  final List<String> tags;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'category': category,
      'imageUrl': imageUrl,
      'publishedAt': publishedAt.toIso8601String(),
      'author': author,
      'views': views,
      'tags': tags,
    };
  }
}