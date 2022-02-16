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
  final List<Procedure?>? procedures;
  final Payment? payment;
  final String status;
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
    required this.status,
  });

  Map<String, dynamic> toJson({
    required String appointment_id,
    required dynamic dateCreated,
  }) {
    return {
      'appointment_id': appointment_id,
      'patient': this.patient,
      'date': this.date,
      'startTime': this.startTime,
      'endTime': this.endTime,
      'dentist': this.dentist,
      'appointment_status': this.appointment_status,
      'procedures': this.procedures,
      'payment': this.payment,
      'status': this.status,
      'dateCreated': dateCreated,
    };
  }

  factory AppointmentModel.fromJson(Map<String, dynamic> map) {
    return AppointmentModel(
        appointment_id: map['appointment_id'] as String,
        patient: map['patient'] as Patient,
        date: map['date'] as String,
        startTime: map['startTime'] as String,
        endTime: map['endTime'] as String,
        dentist: map['dentist'] as String,
        appointment_status: map['appointment_status'] as String,
        procedures: map['procedures'] as List<Procedure?>,
        payment: map['payment'] as Payment,
        status: map['status'] as String,
        dateCreated: map['dateCreated']);
  }
}
