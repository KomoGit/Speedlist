import 'package:speedlist/Utilities/user_utilities.dart';

class LoginUtilities {
  bool emailValidator(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  bool passwordValidator(String pass) {
    return RegExp(
            r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*~]).{8,}$")
        .hasMatch(pass);
  }

  // Validates if password and confirm password are one and the same.
  bool arePasswordsSame(String pass1, String pass2) {
    if (pass1 == pass2) {
      return true;
    }
    return false;
  }

//Thanks Chat-GPT :^)
  String formatErrorMessage(String e) {
    String message = e
        .split('message: ')[1] // Extract the substring after 'message: '
        .split('.')[0] // Extract the substring before the next comma
        .trim();
    return message;
  }

 bool isUserLoggedIn(){
    if(UserUtilities.user.id == "000"){
      return false;
    }
    return true;
 }
}
