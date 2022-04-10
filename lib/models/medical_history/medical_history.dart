class MedicalHistory {
  final dynamic id;
  final String date;
  final String? file;

  const MedicalHistory({
    required this.id,
    required this.date,
    required this.file,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'date': this.date,
      'file': this.file,
    };
  }

  factory MedicalHistory.fromJson(Map<String, dynamic> map) {
    return MedicalHistory(
      id: map['id'] as dynamic,
      date: map['date'] as String,
      file: map['file'] as String,
    );
  }
}
