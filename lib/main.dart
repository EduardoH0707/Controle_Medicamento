// lib/main.dart
import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const ControleMedicamentosApp());
}

class ControleMedicamentosApp extends StatelessWidget {
  const ControleMedicamentosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Controle de Medicamentos',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
