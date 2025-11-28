import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Berita Sederhana',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // Gaya untuk TextField yang konsisten dengan wireframe (border abu-abu)
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Colors.blue),
          ),
          filled: true,
          fillColor: Colors.grey[100],
          contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black, // Tombol Sign In berwarna gelap
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
      ),
      // Routing yang menghubungkan ketiga halaman
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/list': (context) => const NewsListPage(),
        // Detail halaman menggunakan parameter dinamis (bukan Named Route, 
        // tapi kita bisa menggunakan Navigator.push)
      },
      // Menggunakan onGenerateRoute untuk Detail Page
      onGenerateRoute: (settings) {
        if (settings.name == '/detail') {
          // Contoh passing data, meskipun data di sini hanya placeholder
          // final args = settings.arguments as Map<String, dynamic>; 
          return MaterialPageRoute(
            builder: (context) {
              return const NewsDetailPage();
            },
          );
        }
        return null;
      },
    );
  }
}

// --- 2. Halaman Login (Tampilan Kiri) ---
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30.0),
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Placeholder Logo App
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text(
                    'LOGO APP',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50.0),
              
              // Field Username
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'USERNAME',
                ),
              ),
              const SizedBox(height: 20.0),
              
              // Field Password
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'PASSWORD',
                ),
              ),
              const SizedBox(height: 10.0),

              // Forgot Password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'FORGOT PASSWORD',
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              
              // Tombol Sign In (Routing ke Halaman List)
              ElevatedButton(
                onPressed: () {
                  // Menggunakan pushReplacement agar user tidak bisa kembali ke login
                  Navigator.of(context).pushReplacementNamed('/list');
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('SIGN IN'),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- 3. Halaman List/Explore (Tampilan Tengah) ---
class NewsListPage extends StatelessWidget {
  const NewsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Menyembunyikan tombol kembali (karena ini Home)
        title: const Text('Explore', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Filter', style: TextStyle(color: Colors.black)),
          ),
        ],
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        children: [
          // Placeholder List Item 1
          NewsListItem(
            title: 'Vivamus fermentum elementum nunc',
            author: 'by John Allen',
            onTap: () {
              Navigator.of(context).pushNamed('/detail');
            },
          ),
          const Divider(height: 1),
          // Placeholder List Item 2
          NewsListItem(
            title: 'Quisque ex lectus, euismod gravida dolor',
            author: 'by Maria Salomon',
            onTap: () {
              Navigator.of(context).pushNamed('/detail');
            },
          ),
          const Divider(height: 1),
          // Placeholder List Item 3
          NewsListItem(
            title: 'Donec vitae metus et nunc mollis vulputate',
            author: 'by Mark Robertson',
            onTap: () {
              Navigator.of(context).pushNamed('/detail');
            },
          ),
          const Divider(height: 1),
          // ... Tambahkan item lain sesuai kebutuhan
        ],
      ),
      // Bagian bawah (Bottom Navigation Bar)
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark_border), label: 'Saved'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}

// Widget untuk setiap item berita di list
class NewsListItem extends StatelessWidget {
  final String title;
  final String author;
  final VoidCallback onTap;

  const NewsListItem({
    super.key,
    required this.title,
    required this.author,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Placeholder Gambar
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    author,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      // Label 1
                      _buildLabel('LABEL 1'),
                      const SizedBox(width: 5),
                      // Label 2
                      _buildLabel('LABEL 2'),
                      const SizedBox(width: 15),
                      const Icon(Icons.comment_outlined, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      const Text('5 Comments', style: TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  // Helper untuk membuat label
  Widget _buildLabel(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }
}


// --- 4. Halaman Detail (Tampilan Kanan) ---
class NewsDetailPage extends StatelessWidget {
  const NewsDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''), // Kosongkan title (atau bisa dihilangkan)
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black), // Ikon panah kembali
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Placeholder Gambar Utama
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            const SizedBox(height: 20),

            // Judul Berita
            const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            // Penulis
            const Text(
              'by Sarah Town',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),

            // Aksi (Like & Comment)
            Row(
              children: [
                _buildActionButton(icon: Icons.thumb_up_alt_outlined, label: 'Like'),
                const SizedBox(width: 20),
                _buildActionButton(icon: Icons.comment_outlined, label: 'Comment'),
              ],
            ),
            const Divider(height: 30),

            // Konten Berita
            Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\n\nSed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.",
              style: TextStyle(fontSize: 16, height: 1.5, color: Colors.grey[800]),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
  
  // Helper untuk Tombol Aksi
  Widget _buildActionButton({required IconData icon, required String label}) {
    return Row(
      children: [
        Icon(icon, size: 20),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}