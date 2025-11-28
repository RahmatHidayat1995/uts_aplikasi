import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article.dart';

class NewsService {
  final String apiKey = 'c8234914324d431a85f0549ded358997'; 
  final String baseUrl = 'https://newsapi.org/v2';

  Future<List<Article>> fetchTopHeadlines() async {
    // Contoh endpoint: top headlines di US
    final url = Uri.parse('$baseUrl/top-headlines?country=us&apiKey=$apiKey');
    
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List articlesJson = data['articles'] ?? [];
      
      // Filter artikel yang tidak terhapus dan memiliki judul
      return articlesJson
          .map((json) => Article.fromJson(json))
          .where((article) => article.title != "[Removed]" && article.title != null)
          .toList();
    } else {
      // Handle error
      throw Exception('Gagal memuat berita: ${response.statusCode}');
    }
  }
}