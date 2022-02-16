import 'package:dentalapp/core/service/validator/validator_service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ValidatorServiceImpl extends ValidatorService {
  @override
  String? validateFirstName(String value) {
    if (value.isEmpty) {
      return 'First name is empty.';
    }
  }

  @override
  String? validateLastName(String value) {
    if (value.isEmpty) {
      return 'Last name is empty.';
    }
  }

  @override
  String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Password is empty.';
    } else if (value.length < 8) {
      return 'Password must have at least 8 characters.';
    }
  }

  @override
  String? validateConfirmPassword(String value, String password) {
    if (value.isEmpty) {
      return 'Confirm password is empty.';
    } else if (value != password) {
      return 'Confirm Password do not match!';
    }
  }

  @override
  String? validateAddress(String value) {
    if (value.isEmpty) {
      return 'Address is empty';
    }
  }

  @override
  String? validateEmailAddress(String value) {
    bool emailValid = GetUtils.isEmail(value);
    if (value.isEmpty) {
      return 'Email address is empty';
    } else if (!emailValid) {
      return 'Enter a valid Email address';
    }
  }

  @override
  String? validateDate(String value) {
    if (value.isEmpty) {
      return 'Birthdate is empty';
    } else if (DateFormat.yMMMd().parse(value) == null) {
      return 'Birthdate is not valid';
    }
  }

  @override
  String? validateGender(String value) {
    if (value.isEmpty) {
      return 'Gender is empty';
    }
  }

  @override
  String? validatePosition(String value) {
    if (value.isEmpty) {
      return 'Position is empty';
    }
  }

  @override
  String? validateAllergies(String value) {
    if (value.isEmpty) {
      return 'List of Allergies is empty';
    }
  }

  @override
  String? validateContactName(String value) {
    if (value.isEmpty) {
      return 'Contact name is empty';
    }
  }

  @override
  String? validatePhoneNumber(String value) {
    if (value.isEmpty) {
      return 'Phone number is empty';
    } else if (value.length < 11) {
      return 'Phone number is not valid';
    }
  }

  @override
  String? validateBrandName(String value) {
    if (value.isEmpty) {
      return 'Brand name is empty';
    }
  }

  @override
  String? validateMedicineName(String value) {
    if (value.isEmpty) {
      return 'Medicine name is empty';
    }
  }

  @override
  String? validatePrice(String value) {
    if (value.isEmpty) {
      return 'Price is empty';
    }
  }

  @override
  String? validateProcedureName(String value) {
    if (value.isEmpty) {
      return 'Procedure Name is empty';
    }
  }
}
