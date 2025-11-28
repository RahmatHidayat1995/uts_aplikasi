import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // <<< PASTIKAN INI ADA
import '../models/article.dart';
// import library

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key}); 

  // Fungsi untuk meluncurkan URL (Link Eksternal)
  void _launchURL(String? url) async {
    // Memastikan URL tidak null
    if (url == null || url.isEmpty) {
      // Tampilkan pesan jika URL kosong
      return; 
    }
    
    // Konversi String URL menjadi objek Uri
    final Uri uri = Uri.parse(url);

    // Cek apakah perangkat dapat meluncurkan URL tersebut
    if (await canLaunchUrl(uri)) {
      // Luncurkan URL menggunakan mode eksternal (membuka di browser)
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      // Tampilkan pesan error jika gagal
      // Anda bisa menggunakan ScaffoldMessenger untuk menampilkan Snackbar
      // contoh:
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('Gagal membuka tautan: $url')),
      // );
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Ambil Article dari route arguments
    // Pastikan ini dijalankan setelah widget MaterialApp mendefinisikan rute /detail
    final Article article = ModalRoute.of(context)!.settings.arguments as Article;

    return Scaffold(
      appBar: AppBar(title: Text(article.title ?? 'Detail Berita')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Image Berita
            article.urlToImage != null
                ? Image.network(
                    article.urlToImage!,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(height: 200, width: double.infinity, color: Colors.grey, alignment: Alignment.center, child: const Icon(Icons.broken_image, size: 50)),
                  )
                : Container(height: 200, width: double.infinity, color: Colors.grey),
            
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Judul Berita
                  Text(
                    article.title ?? 'Judul Tidak Tersedia',
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(Icons.thumb_up, size: 20, color: Colors.blue),
                      const SizedBox(width: 4),
                      const Text('Like'),
                      const SizedBox(width: 20),
                      const Icon(Icons.comment, size: 20, color: Colors.blue),
                      const SizedBox(width: 4),
                      const Text('Comment'),
                    ],
                  ),
                  const Divider(height: 32),
                  // Konten Berita
                  // Kita tampilkan content, jika null, tampilkan description
                  Text(
                    article.content ?? article.description ?? 'Konten tidak tersedia.',
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                  
                  // Tambahkan teks ini untuk menjelaskan mengapa artikel terpotong
                  const Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      'Konten di atas adalah cuplikan. Silakan klik tombol di bawah untuk membaca artikel selengkapnya di situs berita asli.',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // TOMBOL UNTUK MEMBACA ARTIKEL LENGKAP
                   ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    onPressed: () => _launchURL(article.articleUrl), 
                    child: const Text('Baca Selengkapnya (External Link)'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}