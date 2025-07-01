// lib/pages/home_page.dart
import 'package:flutter/material.dart';
import '../models/medication.dart';
import 'add_medication_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Medication> medications = [];

  @override
  void initState() {
    super.initState();
    loadMedications();
  }

  void loadMedications() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('medications');
    if (data != null) {
      final decoded = jsonDecode(data) as List;
      setState(() {
        medications = decoded.map((e) => Medication.fromMap(e)).toList();
      });
    }
  }

  void saveMedications() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(medications.map((e) => e.toMap()).toList());
    await prefs.setString('medications', encoded);
  }

  void addMedication(Medication med) {
    setState(() {
      medications.add(med);
    });
    saveMedications();
  }

  void deleteMedication(int index) {
    setState(() {
      medications.removeAt(index);
    });
    saveMedications();
  }

  void toggleTaken(int index) {
    setState(() {
      medications[index].taken = !medications[index].taken;
    });
    saveMedications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Controle de Medicamentos'),
      ),
      body: ListView.builder(
        itemCount: medications.length,
        itemBuilder: (context, index) {
          final med = medications[index];
          return ListTile(
            title: Text(med.name),
            subtitle: Text('${med.dosage} - ${med.time}'),
            trailing: Row(
  mainAxisSize: MainAxisSize.min,
  children: [
    Checkbox(
      value: med.taken,
      onChanged: (_) => toggleTaken(index),
    ),
    PopupMenuButton<String>(
      onSelected: (value) async {
        if (value == 'edit') {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddMedicationPage(
                existing: med,
                index: index,
              ),
            ),
          );
          if (result != null && result is Medication) {
            setState(() {
              medications[index] = result;
            });
            saveMedications();
          }
        } else if (value == 'delete') {
          deleteMedication(index);
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem(value: 'edit', child: Text('Editar')),
        const PopupMenuItem(value: 'delete', child: Text('Excluir')),
      ],
    ),
  ],
),

          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddMedicationPage()),
          );
          if (result != null && result is Medication) {
            addMedication(result);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
