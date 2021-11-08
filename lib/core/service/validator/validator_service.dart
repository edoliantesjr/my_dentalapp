abstract class ValidatorService {
  String? validateFirstName(String value);

  String? validateLastName(String value);

  String? validatePassword(String value);

  String? validateConfirmPassword(String value, String password);

  String? validateAddress(String value);

  String? validateEmailAddress(String value);

  String? validateDate(String value);

  String? validateGender(String value);
}
