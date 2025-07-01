// lib/pages/add_medication_page.dart
import 'package:flutter/material.dart';
import '../models/medication.dart';

class AddMedicationPage extends StatefulWidget {
  final Medication? existing;
  final int? index;

  const AddMedicationPage({super.key, this.existing, this.index});

  @override
  State<AddMedicationPage> createState() => _AddMedicationPageState();
}


class _AddMedicationPageState extends State<AddMedicationPage> {
  final nameController = TextEditingController();
  final dosageController = TextEditingController();
  TimeOfDay? selectedTime;

  @override
void initState() {
  super.initState();
  if (widget.existing != null) {
    nameController.text = widget.existing!.name;
    dosageController.text = widget.existing!.dosage;

    // Parse o horário do tipo "HH:mm"
    final timeParts = widget.existing!.time.split(':');
    final hour = int.tryParse(timeParts[0]) ?? 0;
    final minute = int.tryParse(timeParts[1]) ?? 0;

    selectedTime = TimeOfDay(hour: hour, minute: minute);
  }
}


  void pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      setState(() {
        selectedTime = time;
      });
    }
  }

  void saveMedication() {
  if (nameController.text.isEmpty || dosageController.text.isEmpty || selectedTime == null) return;

  final medication = Medication(
    name: nameController.text,
    dosage: dosageController.text,
    time: selectedTime!.format(context),
  );

  Navigator.pop(context, medication);
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
  title: const Text('Novo Medicamento'),
  leading: IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: () => Navigator.pop(context),
  ),
),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Nome do medicamento'),
            ),
            TextField(
              controller: dosageController,
              decoration: const InputDecoration(labelText: 'Dosagem'),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text(selectedTime == null ? 'Horário não selecionado' : 'Horário: ${selectedTime!.format(context)}'),
                const Spacer(),
                TextButton(
                  onPressed: pickTime,
                  child: const Text('Selecionar horário'),
                ),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: saveMedication,
                  child: const Text('Salvar'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
