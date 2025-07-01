class Medication {
  String name;
  String dosage;
  String time;
  bool taken;

  Medication({
    required this.name,
    required this.dosage,
    required this.time,
    this.taken = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'dosage': dosage,
      'time': time,
      'taken': taken,
    };
  }

  factory Medication.fromMap(Map<String, dynamic> map) {
    return Medication(
      name: map['name'],
      dosage: map['dosage'],
      time: map['time'],
      taken: map['taken'],
    );
  }
}
