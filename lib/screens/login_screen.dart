import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _errorMessage;

  // Warna Utama untuk desain
  final Color primaryColor = Colors.deepPurple; 

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // 👇 METHOD INI MENGOSONGKAN FIELD DAN MERESET FORM
  void _resetForm() {
    setState(() {
      _usernameController.clear(); // ⭐ Mengosongkan field USERNAME
      _passwordController.clear(); // ⭐ Mengosongkan field PASSWORD
      _errorMessage = null;
      _formKey.currentState?.reset();
    });
    FocusScope.of(context).unfocus();
  }

  void _handleLogin() {
    setState(() {
      _errorMessage = null;
    });

    final username = _usernameController.text;
    final password = _passwordController.text;

    if (username == 'dayat' && password == '1234') {
      Navigator.of(context).pushReplacementNamed('/list');
    } else {
      setState(() {
        _errorMessage = 'Username atau Password salah. (Hint: dayat/1234)';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // --- APPBAR TRANSPRAN (TOMBOL RESET) ---
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: primaryColor.withOpacity(0.6)), 
            tooltip: 'Reset Form',
            onPressed: _resetForm, // 👈 Tombol memanggil _resetForm()
          ),
        ],
      ),
      // ------------------------------------
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                
                // --- KODING LOGO ---
                Image.asset(
                  'assets/logo.png',
                  height: 120,
                ),
                const SizedBox(height: 16),
                // -------------------
                
                const Text(
                  'NEWS EXPLORER',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54
                  ),
                ),
                const SizedBox(height: 50),

                // --- FIELD USERNAME ---
                TextFormField(
                  controller: _usernameController, // ⭐ Terikat dengan _usernameController
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: 'USERNAME', 
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: primaryColor, width: 2.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Username tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // --- FIELD PASSWORD ---
                TextFormField(
                  controller: _passwordController, // ⭐ Terikat dengan _passwordController
                  obscureText: true,
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: 'PASSWORD', 
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: primaryColor, width: 2.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                // Pesan Error
                if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ),

                // Forgot Password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text('FORGOT PASSWORD?', style: TextStyle(color: primaryColor)),
                  ),
                ),
                const SizedBox(height: 30),

                // --- TOMBOL SIGN IN ---
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _handleLogin();
                    }
                  },
                  child: const Text('SIGN IN', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}