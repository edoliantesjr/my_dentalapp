class UserModel {
  String userId;
  String firstName;
  String lastName;
  String email;
  String image;
  String position;
  List<String> appointments;
  List<String> searchIndex;
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
    required this.searchIndex,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(json['uid'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        email: json['email'],
        image: json['image'],
        position: json['position'],
        appointments:
            json['appointments'] != null ? List.from(json['appointments']) : [],
        fcmToken: json['fcmToken'] != null ? List.from(json['fcmToken']) : [],
        searchIndex: []);
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
      'searchIndex': searchIndex,
    };
  }

  String get fullName => firstName + ' ' + lastName;
}
