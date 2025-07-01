// lib/pages/welcome_page.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  Future<void> _completeTutorial(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('saw_tutorial', true);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade50,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.medication, size: 100, color: Colors.teal),
            const SizedBox(height: 24),
            const Text(
              'Bem-vindo ao Controle de Medicamentos!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              'Este aplicativo vai te ajudar a lembrar dos seus medicamentos.\n\nVocê pode:\n• Cadastrar horários\n• Marcar como "Tomado"\n• Editar ou excluir remédios\n\nÉ simples, rápido e feito para facilitar seu dia a dia.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => _completeTutorial(context),
              child: const Text('Começar'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                textStyle: const TextStyle(fontSize: 18),
              ),
            )
          ],
        ),
      ),
    );
  }
}
