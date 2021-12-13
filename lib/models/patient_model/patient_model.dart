class PatientModel {
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

  PatientModel({
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
  });

  Map<String, dynamic> toJson({required String? patientId}) {
    return {
      'id': patientId,
      'image': this.image,
      'firstName': this.firstName,
      'lastName': this.lastName,
      'gender': this.gender,
      'birthDate': this.birthDate,
      'phoneNum': this.phoneNum,
      'address': this.address,
      'allergies': this.allergies,
      'notes': this.notes ?? '',
      'emergencyContactName': this.emergencyContactName ?? '',
      'emergencyContactNumber': this.emergencyContactNumber ?? '',
    };
  }

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
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
    );
  }
}
