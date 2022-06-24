// ignore_for_file: non_constant_identifier_names

import 'package:dentalapp/models/patient_model/patient_model.dart';
import 'package:dentalapp/models/procedure/procedure.dart';

class AppointmentModel {
  final String? appointment_id;
  final Patient patient;
  final String date;
  final String startTime;
  final String endTime;
  final String dentist;
  final String appointment_status;

  final List<dynamic>? procedures;
  final String? dateCreated;
  final bool? isAccepted;

  const AppointmentModel({
    this.appointment_id,
    required this.patient,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.dentist,
    required this.appointment_status,
    this.procedures,
    this.dateCreated,
    this.isAccepted,
  });

  Map<String, dynamic> toJson(
      {required String appointment_id,
      required dynamic dateCreated,
      required String patientId}) {
    return {
      'appointment_id': appointment_id,
      'patient':
          patient.toJson(patientId: patientId, dateCreated: dateCreated),
      'date': date,
      'startTime': startTime,
      'endTime': endTime,
      'dentist': dentist,
      'appointment_status': appointment_status,
      'procedures': procedures
          ?.map((e) => e.toJson(dateCreated: e.dateCreated, id: e.id))
          .toList(),
      // ?.map((e) => e?.toJson(dateCreated: this.date)),
      'dateCreated': dateCreated,
      'isAccepted': isAccepted ?? true,
    };
  }

  factory AppointmentModel.fromJson(Map<String, dynamic> map) {
    final patient = map['patient'];
    return AppointmentModel(
        appointment_id: map['appointment_id'] as String,
        patient: Patient.fromJson(patient),
        date: map['date'] as String,
        startTime: map['startTime'] as String,
        endTime: map['endTime'] as String,
        dentist: map['dentist'] as String,
        isAccepted: map['isAccepted,'],
        appointment_status: map['appointment_status'] as String,
        procedures: map['procedures']
            .map((procedure) => Procedure.fromJson(procedure))
            .toList(),
        dateCreated: map['dateCreated'].toString());
  }
}
