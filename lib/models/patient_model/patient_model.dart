import 'package:dentalapp/models/medical_history/medical_history.dart';

class Patient {
  final dynamic id;
  final dynamic image;
  final String firstName;
  final String lastName;
  final String gender;
  final String birthDate;
  final String phoneNum;
  final String address;
  final String? allergies;
  final dynamic notes;
  final String? emergencyContactName;
  final String? emergencyContactNumber;
  final List<String> searchIndex;
  final dynamic dateCreated;
  final List<MedicalHistory?>? medicalHistory;

  Patient({
    this.id,
    this.image,
    this.notes,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.birthDate,
    required this.phoneNum,
    required this.address,
    required this.allergies,
    this.emergencyContactName,
    this.emergencyContactNumber,
    this.dateCreated,
    required this.searchIndex,
    this.medicalHistory,
  });

  Map<String, dynamic> toJson(
      {required String? patientId, required dynamic dateCreated}) {
    return {
      'id': patientId,
      'image': this.image,
      'firstName': this.firstName,
      'lastName': this.lastName,
      'fullName': this.fullName,
      'gender': this.gender,
      'birthDate': this.birthDate,
      'phoneNum': this.phoneNum,
      'address': this.address,
      'allergies': this.allergies,
      'notes': this.notes ?? '',
      'emergencyContactName': this.emergencyContactName ?? '',
      'emergencyContactNumber': this.emergencyContactNumber ?? '',
      'dateCreated': dateCreated,
      'searchIndex': this.searchIndex,
      'medicalHistory': medicalHistory?.map((e) => e?.toJson()),
    };
  }

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'] as dynamic,
      image: json['image'] as dynamic,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      gender: json['gender'] as String,
      birthDate: json['birthDate'] as String,
      phoneNum: json['phoneNum'] as String,
      address: json['address'] as String,
      allergies: json['allergies'] ?? '',
      notes: json['notes'] as String,
      emergencyContactName: json['emergencyContactName'] ?? '',
      emergencyContactNumber: json['emergencyContactNumber'] ?? '',
      searchIndex: [],
      medicalHistory: json['medicalHistory'] != null
          ? json['medicalHistory']
              .map((medicalHistory) => MedicalHistory.fromJson(medicalHistory))
              .toList()
          : null,
    );
  }
  String get fullName => firstName + ' ' + lastName;
}
