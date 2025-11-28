class Article {
  final String? title;
  final String? description;
  final String? urlToImage;
  final String? content;
  final String? articleUrl; // URL artikel lengkap

  Article({this.title, this.description, this.urlToImage, this.content, this.articleUrl});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] as String?,
      description: json['description'] as String?,
      urlToImage: json['urlToImage'] as String?,
      content: json['content'] as String?,
      articleUrl: json['url'] as String?,
    );
  }
}