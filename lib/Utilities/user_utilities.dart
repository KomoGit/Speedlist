import '../model/user.dart';

class UserUtilities {
  static UserModel user = UserModel("Please Login", "000", "Please Register For Account",userProfilePicture,true);
  static String userProfilePicture = "https://cdn.jsdelivr.net/gh/devicons/devicon/icons/android/android-original.svg"; //default profile picture

  UserUtilities(UserModel usr, String pfp) {
    user = usr;
    userProfilePicture = pfp;
  }

  // When logging out we set the user to default user. Code gets repeated here. So we need to find a way to call this code when instead of setting UserModel twice.
  static void setUserToDefault(){
    user = UserModel("Please Login", "000", "Please Register For Account",userProfilePicture,true);
  }
}
