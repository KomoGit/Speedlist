class LoginUtilities {
  bool emailValidator(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  bool passwordValidator(String pass) {
    return RegExp(
            r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$")
        .hasMatch(pass);
  }

  // Validates if password and confrim password are one and the same.
  bool arePasswordsSame(String pass1, String pass2) {
    if (pass1 == pass2) {
      return true;
    }
    return false;
  }

  String formatErrorMessage(String e) {
    String message = e
        .toString()
        .split('message: ')[2] // Extract the substring after 'message: '
        .split('.')[0] // Extract the substring before the next comma
        .trim();
    return message;
  }
}
