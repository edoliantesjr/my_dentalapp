import 'package:dentalapp/models/procedure/procedure.dart';

class DentalNotes {
  final String selectedTooth;
  final Procedure procedure;
  final String date;
  final String note;
  final dynamic id;
  bool isPaid;

  DentalNotes({
    this.id,
    required this.isPaid,
    required this.selectedTooth,
    required this.procedure,
    required this.date,
    required this.note,
  });

  Map<String, dynamic> toJson(
      {required dynamic id, required dynamic procedureId}) {
    return {
      'id': id,
      'selectedTooth': selectedTooth,
      'procedure': procedure
          .toJson(dateCreated: DateTime.now().toString(), id: procedureId),
      'date': date,
      'note': note,
      'isPaid': isPaid,
    };
  }

  factory DentalNotes.fromJson(Map<String, dynamic> map) {
    return DentalNotes(
      id: map['id'] as dynamic,
      selectedTooth: map['selectedTooth'] as String,
      procedure: Procedure.fromJson(map['procedure']),
      date: map['date'] as String,
      note: map['note'] as String,
      isPaid: map['isPaid'] as bool,
    );
  }
}
