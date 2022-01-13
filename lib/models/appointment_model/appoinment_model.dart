import 'package:dentalapp/models/patient_model/patient_model.dart';

class AppointmentModel {
  //TODO: To modify  appointment model

  final String? appointment_id;
  final Patient patient;
  final String serviceTitle;
  final String dateDay;
  final String dateMonth;
  final String doctor;
  final String status;

  const AppointmentModel({
    this.appointment_id,
    required this.patient,
    required this.serviceTitle,
    required this.dateDay,
    required this.dateMonth,
    required this.doctor,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'appointment_id': this.appointment_id,
      'serviceTitle': this.serviceTitle,
      'dateDay': this.dateDay,
      'dateMonth': this.dateMonth,
      'doctor': this.doctor,
      'patient': this.patient,
      'status': this.status,
    };
  }

  factory AppointmentModel.fromJson(Map<String, dynamic> map) {
    return AppointmentModel(
      appointment_id: map['appointment_id'] as String,
      serviceTitle: map['serviceTitle'] as String,
      dateDay: map['dateDay'] as String,
      dateMonth: map['dateMonth'] as String,
      doctor: map['doctor'] as String,
      patient: map['patient_id'],
      status: map['status'] as String,
    );
  }
}
