import 'package:flutter/material.dart';
import '../models/article.dart';
import '../services/news_service.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  late Future<List<Article>> _futureArticles;
  final NewsService _newsService = NewsService();

  @override
  void initState() {
    super.initState();
    _futureArticles = _newsService.fetchTopHeadlines();
  }
  
  // Fungsi untuk menangani Logout
  void _handleLogout() {
    // Navigasi ke halaman Login ('/') dan menghapus semua rute sebelumnya
    // agar pengguna tidak bisa kembali ke halaman List dengan tombol 'back'.
    Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          // --- TOMBOL LOGOUT BARU ---
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.black),
            tooltip: 'Logout',
            onPressed: _handleLogout, // Panggil fungsi logout
          ),
          // --- Tombol Filter (sudah ada sebelumnya) ---
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.black), 
            onPressed: () {
              // Aksi untuk Filter
            }
          ),
        ],
      ),
      body: FutureBuilder<List<Article>>(
        future: _futureArticles,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final article = snapshot.data![index];
                return ListTile(
                  title: Text(article.title ?? 'No Title'),
                  subtitle: Text(article.description ?? 'No Description', maxLines: 2, overflow: TextOverflow.ellipsis),
                  leading: article.urlToImage != null
                      ? Image.network(
                          article.urlToImage!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(width: 100, height: 100, color: Colors.grey, child: const Icon(Icons.broken_image)),
                        )
                      : Container(width: 100, height: 100, color: Colors.grey),
                  onTap: () {
                    // Navigasi ke Halaman Detail dengan membawa objek Article
                    Navigator.of(context).pushNamed(
                      '/detail',
                      arguments: article,
                    );
                  },
                );
              },
            );
          } else {
            return const Center(child: Text('Tidak ada berita ditemukan.'));
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {},
      ),
    );
  }
}