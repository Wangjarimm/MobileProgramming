import 'package:flutter/material.dart';

import 'mainpage.dart'; // import halaman utama

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(), // Mengarahkan langsung ke halaman utama
    );
  }
}
