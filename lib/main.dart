import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/list_screen.dart';
import 'screens/detail_screen.dart';
// Import model dan service jika diperlukan

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      theme: ThemeData(primarySwatch: Colors.blue),
      // Tentukan rute awal
      initialRoute: '/', 
      routes: {
        '/': (context) => const LoginScreen(),
        '/list': (context) => const ListScreen(),
        // DetailScreen akan menangani argumen (artikel)
        '/detail': (context) => const DetailScreen(), 
      },
      // ... atau gunakan onGenerateRoute untuk routing dengan argumen
      // onGenerateRoute: (settings) {
      //   if (settings.name == '/detail') {
      //     final args = settings.arguments as Article;
      //     return MaterialPageRoute(
      //       builder: (context) => DetailScreen(article: args),
      //     );
      //   }
      //   return null; 
      // },
    );
  }
}