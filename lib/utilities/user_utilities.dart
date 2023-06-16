import 'package:speedlist/Utilities/login_utilities.dart';

import '../model/user.dart';

class UserUtilities {
  static final LoginUtilities _loginUtilities = LoginUtilities();
  static UserModel user = UserModel("Please Login", userProfilePicture, "000","example@example.com",true);
  static String userProfilePicture = "https://images.pexels.com/photos/339379/pexels-photo-339379.jpeg?cs=srgb&dl=pexels-marek-339379.jpg&fm=jpg"; //default profile picture

  UserUtilities(UserModel usr, String pfp) {
    user = usr;
    userProfilePicture = pfp;
  }

  // When logging out we set the user to default user. Code gets repeated here. So we need to find a way to call this code when instead of setting UserModel twice.
  static void setUserToDefault(){
    user = UserModel("Please Login", userProfilePicture, "000","example@example.com",true);
    _loginUtilities.rememberUserLogin = false;
  }
}
