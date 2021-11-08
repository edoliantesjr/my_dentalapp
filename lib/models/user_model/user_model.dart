class UserModel {
  String userId;
  String firstName;
  String lastName;
  String email;
  String image;
  String position;
  List<String> appointment;
  List<dynamic> fcmToken;

  UserModel(this.userId,
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.image,
      required this.position,
      required this.appointment,
      required this.fcmToken});
}
