import 'package:firebase_auth/firebase_auth.dart';

class UserInputValidator {
  static String? validateUserAddressFields(String? input) {
    if (input == null || input.isEmpty) {
      return 'Please enter a value!';
    }
    return null;
  }

  static String? validateNoOfPersonsDeclared(String? input) {
    RegExp noOfPersonsDeclaredRegExp = RegExp(r"^[0-9]*$");
    if (input == null || input.isEmpty) {
      return 'Please enter a value!';
    } else if (!noOfPersonsDeclaredRegExp.hasMatch(input)) {
      return 'You should enter an integer!';
    }
    return null;
  }

  static String? validateIndexesValues(String? input) {
    RegExp indexesValuesRegExp = RegExp(r"^[0-9]*$");
    if (input == null || input.isEmpty) {
      return 'Please enter a value!';
    } else if (!indexesValuesRegExp.hasMatch(input)) {
      return 'You should enter an integer!';
    }
    return null;
  }

  static String? validateReportFormEmailField(String? input) {
    final email = FirebaseAuth.instance.currentUser!.email;
    RegExp complaintsEmailFieldRegExp = RegExp(
        r"[a-z0-9!#$%&'*+=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");
    if (input == null || input.isEmpty) {
      return 'Please enter an email!';
    } else if (!complaintsEmailFieldRegExp.hasMatch(input)) {
      return 'Please enter a valid email!';
    } else if (input != email) {
      return 'Email address doesn\'t match the one you\n registered!';
    }
    return null;
  }

  static String? validatedUserEmail(String? userEmail) {
    RegExp emailRegExp = RegExp(
        r"[a-z0-9!#$%&'*+=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");

    if (userEmail == null || userEmail.isEmpty) {
      return 'Please enter an email!';
    } else if (!emailRegExp.hasMatch(userEmail)) {
      return 'Please enter a valid email!';
    }

    return null;
  }

  static String? validatedUserPassword(String? userPassword) {
    RegExp passwordRegExp =
        RegExp(r"(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$");

    if (userPassword == null || userPassword.isEmpty) {
      return 'Please enter a password!';
    } else if (userPassword.length < 6) {
      return 'Password should be at least 6 characters!';
    } else if (!passwordRegExp.hasMatch(userPassword)) {
      return 'Password should contain minimum 1: \nupper and lower case,  numeric number, \nspecial char, common char(! @ # * `).';
    }

    return null;
  }
}
