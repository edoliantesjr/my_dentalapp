import 'package:dentalapp/models/procedure/procedure.dart';

class DentalNotes {
  final String selectedTooth;
  final Procedure procedure;
  final String date;
  final String note;
  final dynamic id;
  final bool isPaid;

  const DentalNotes({
    this.id,
    required this.isPaid,
    required this.selectedTooth,
    required this.procedure,
    required this.date,
    required this.note,
  });

  Map<String, dynamic> toJson({required dynamic id}) {
    return {
      'id': id,
      'selectedTooth': this.selectedTooth,
      'procedure':
          this.procedure.toJson(dateCreated: DateTime.now().toString()),
      'date': this.date,
      'note': this.note,
      'isPaid': this.isPaid,
    };
  }

  factory DentalNotes.fromJson(Map<String, dynamic> map) {
    return DentalNotes(
      id: map['id'] as dynamic,
      selectedTooth: map['selectedTooth'] as String,
      procedure: map['procedure'] as Procedure,
      date: map['date'] as String,
      note: map['note'] as String,
      isPaid: map['isPaid'] as bool,
    );
  }
}
