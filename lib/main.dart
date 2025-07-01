import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/home_page.dart';
import 'pages/welcome_page.dart';

void main() {
  runApp(const ControleMedicamentosApp());
}

class ControleMedicamentosApp extends StatelessWidget {
  const ControleMedicamentosApp({super.key});

  Future<bool> checkTutorialSeen() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('saw_tutorial') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Controle de Medicamentos',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<bool>(
        future: checkTutorialSeen(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return snapshot.data! ? const HomePage() : const WelcomePage();
        },
      ),
    );
  }
}
