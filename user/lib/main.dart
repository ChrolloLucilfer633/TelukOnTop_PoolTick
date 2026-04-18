import 'package:flutter/material.dart';
import 'pages/home_page.dart'; // Import halaman utama

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: const Color(0xFF0D6EFD),
      fontFamily: 'Poppins', // Pastikan sudah daftar di pubspec.yaml
    ),
    home: const HomePage(), // Jalankan Landing Page
  ));
}