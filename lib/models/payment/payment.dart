import 'package:dentalapp/models/medicine/medicine.dart';

import '../dental_notes/dental_notes.dart';

class Payment {
  final String? payment_id;
  final String patient_id;
  final String patient_name;
  final String dentist;
  final List<DentalNotes>? dentalNote;
  final List<Medicine>? medicineList;
  final String dentalNoteSubTotal;
  final String medicineSubTotal;
  final String totalAmount;
  final String payment_type;

  const Payment({
    this.payment_id,
    required this.patient_name,
    this.medicineList,
    required this.patient_id,
    required this.dentist,
    this.dentalNote,
    required this.dentalNoteSubTotal,
    required this.medicineSubTotal,
    required this.totalAmount,
    required this.payment_type,
  });

  Map<String, dynamic> toJson(dynamic id) {
    return {
      'payment_id': id,
      'dentist': this.dentist,
      'dentalNote': this
          .dentalNote
          ?.map((e) => e.toJson(id: e.id, procedureId: e.procedure.id))
          .toList(),
      'medicineList': medicineList
          ?.map((e) =>
              e.toJson(dateCreated: e.dateCreated, id: e.id, image: e.image))
          .toList(),
      'dentalNoteSubTotal': this.dentalNoteSubTotal,
      'medicineSubTotal': this.medicineSubTotal,
      'totalAmount': this.totalAmount,
      'payment_type': this.payment_type,
      'patient_id': this.patient_id,
      'patient_name': this.patient_name,
    };
  }

  factory Payment.fromMap(Map<String, dynamic> map) {
    return Payment(
      payment_id: map['payment_id'] as String,
      dentist: map['dentist'] as String,
      dentalNote: map['dentalNote']
          .map((dentalNote) => DentalNotes.fromJson(dentalNote))
          .toList(),
      medicineList: map['medicineList']
          .map((medicine) => Medicine.fromJson(medicine))
          .toList(),
      dentalNoteSubTotal: map['dentalNoteSubTotal'] as String,
      medicineSubTotal: map['medicineSubTotal'] as String,
      totalAmount: map['totalAmount'] as String,
      payment_type: map['payment_type'] as String,
      patient_id: map['patient_id'] as String,
      patient_name: map['patient_name'],
    );
  }
}
