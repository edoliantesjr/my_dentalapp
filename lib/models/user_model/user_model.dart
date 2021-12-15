class UserModel {
  String userId;
  String firstName;
  String lastName;
  String email;
  String image;
  String position;
  List<String> appointments;
  List<dynamic> fcmToken;

  UserModel(
    this.userId, {
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.image,
    required this.position,
    required this.appointments,
    required this.fcmToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      json['uid'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      image: json['image'],
      position: json['position'],
      appointments:
          json['appointments'] != null ? List.from(json['appointments']) : [],
      fcmToken: json['fcmToken'] != null ? List.from(json['fcmToken']) : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': userId,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'image': image,
      'position': position,
      'appointments': appointments,
      'fcmToken': fcmToken,
    };
  }

  String get fullName => firstName + ' ' + lastName;
}
