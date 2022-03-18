import 'package:dentalapp/models/patient_model/patient_model.dart';
import 'package:dentalapp/models/payment/payment.dart';
import 'package:dentalapp/models/procedure/procedure.dart';

class AppointmentModel {
  //TODO: To modify  appointment model
  final String? appointment_id;
  final Patient patient;
  final String date;
  final String startTime;
  final String endTime;
  final String dentist;
  final String appointment_status;
  final List<dynamic>? procedures;
  final Payment? payment;
  final String? dateCreated;

  const AppointmentModel({
    this.appointment_id,
    required this.patient,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.dentist,
    required this.appointment_status,
    this.procedures,
    this.payment,
    this.dateCreated,
  });

  Map<String, dynamic> toJson(
      {required String appointment_id,
      required dynamic dateCreated,
      required String patientId}) {
    return {
      'appointment_id': appointment_id,
      'patient':
          this.patient.toJson(patientId: patientId, dateCreated: dateCreated),
      'date': this.date,
      'startTime': this.startTime,
      'endTime': this.endTime,
      'dentist': this.dentist,
      'appointment_status': this.appointment_status,
      'procedures': this
          .procedures
          ?.map((e) => e.toJson(dateCreated: e.dateCreated, id: e.id))
          .toList(),
      // ?.map((e) => e?.toJson(dateCreated: this.date)),
      'payment': this.payment,
      'dateCreated': dateCreated,
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
        appointment_status: map['appointment_status'] as String,
        procedures: map['procedures']
            .map((procedure) => Procedure.fromJson(procedure))
            .toList(),
        payment: map['payment'],
        dateCreated: map['dateCreated'].toString());
  }
}