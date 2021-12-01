class AppointmentModel {
  final String serviceTitle;
  final String dateDay;
  final String dateMonth;
  final String doctor;
  final String patient;
  final String status;

  const AppointmentModel({
    required this.serviceTitle,
    required this.dateDay,
    required this.dateMonth,
    required this.doctor,
    required this.patient,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
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
      serviceTitle: map['serviceTitle'] as String,
      dateDay: map['dateDay'] as String,
      dateMonth: map['dateMonth'] as String,
      doctor: map['doctor'] as String,
      patient: map['patient'] as String,
      status: map['status'] as String,
    );
  }
}
