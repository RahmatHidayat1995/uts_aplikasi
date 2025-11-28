import 'package:flutter/material.dart';

// Fungsi utama untuk menjalankan aplikasi Flutter
void main() {
  runApp(const LoginApp());
}

// Widget utama yang mendefinisikan aplikasi
class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Halaman Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(), // Menetapkan LoginPage sebagai halaman awal
    );
  }
}

// Widget untuk halaman login
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controller untuk mengontrol input text field
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Fungsi yang dipanggil saat tombol Login ditekan
  void _login() {
    // Di sini Anda akan menambahkan logika otentikasi
    // Misalnya, memanggil API atau memeriksa kredensial
    print('Username/Email: ${_usernameController.text}');
    print('Password: ${_passwordController.text}');

    // Tambahkan navigasi ke halaman berikutnya di sini
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Mencoba Login...')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30.0), // Padding di sekitar form
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Judul atau Logo
              const Text(
                'Selamat Datang!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 40), // Jarak

              // Field Input Username/Email
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username atau Email',
                  hintText: 'Masukkan username atau email Anda',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20), // Jarak

              // Field Input Password
              TextFormField(
                controller: _passwordController,
                obscureText: true, // Untuk menyembunyikan teks password
                decoration: const InputDecoration(
                  labelText: 'Password',
                  hintText: 'Masukkan password Anda',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ),
              const SizedBox(height: 30), // Jarak

              // Tombol Login
              ElevatedButton(
                onPressed: _login, // Memanggil fungsi _login saat ditekan
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Warna tombol
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'LOGIN',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              
              // Opsi lupa password
              TextButton(
                onPressed: () {
                  // Logika untuk Lupa Password
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Anda menekan Lupa Password?')),
                  );
                },
                child: const Text('Lupa Password?'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}