import '../model/user.dart';

class UserUtilities {
  static UserModel user = UserModel("Please Login", "000", "Please Register For Account",userProfilePicture,true);
  static String userProfilePicture = "https://cdn.jsdelivr.net/gh/devicons/devicon/icons/android/android-original.svg";

  UserUtilities(UserModel usr, String pfp) {
    user = usr;
    userProfilePicture = pfp;
  }
}
