import 'package:get/get_utils/src/extensions/string_extensions.dart';

/// App Validator class
class AppValidator {
  /// Validate mobile number
  static String? validateMobileNumber(String? value) {
    if ((value?.isEmpty ?? false) || value == null) {
      return 'Please enter mobile number';
    }

    if(value.length < 10){
      return 'Please enter valid mobile number';
    }
    return null;
  }

  /// Validate Email
  static String? validateEmail(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Please enter the email';
    } else if (!(value?.isEmail ?? false)) {
      return 'Please enter valid email';
    }
    return null;
  }

  /// Validate Gender
  static String? validateGender(String? value) {
    if ((value?.isEmpty ?? false) || value == null) {
      return 'Please select Gender';
    }
    return null;
  }

  /// Name validator
  static String? validateFirstName(String? value) {
    if (value?.isEmpty ?? true) {
      return "Please enter the valid 'Name'";
    }
    if (value!.length > 25) {
      return 'Name must not be more than 25 characters';
    }
    return null;
  }

  /// Validate Middle Name
  static String? validateLastName(String? value) {
    if (value?.isEmpty ?? true) {
      return "Please enter the valid 'Name'";
    }
    if (value!.length > 25) {
      return 'Name must not be more than 25 characters';
    }
    return null;
  }

  /// Validate Middle Name
  static String? validateMiddleName(String? value) {
    if (value?.isEmpty ?? true) {
      return "Please enter the valid 'Name'";
    }
    if (value!.length > 25) {
      return 'Name must not be more than 25 characters';
    }
    return null;
  }



  /// Validate otp
  static String? validateOtp(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Please enter the OTP';
    }

    if ((value?.length ?? 0) != 4) {
      return 'Please enter the valid OTP';
    }
    return null;
  }

  /// Validate Birth date
  static String? validateBirthDate(DateTime? date) {
    if (date == null) {
      return "Please enter the valid 'Birth Date'";
    }

    if (date.isAfter(DateTime.now())) {
      return "Please enter the valid 'Birth Date'";
    }

    // Get the current date
    final DateTime today = DateTime.now();

    // Calculate the date 18 years ago
    final DateTime eighteenYearsAgo = DateTime(
      today.year - 18,
      today.month,
      today.day,
    );

    if (date.isAfter(eighteenYearsAgo)) {
      return 'You must be at least 18 years old';
    }

    return null;
  }
}
