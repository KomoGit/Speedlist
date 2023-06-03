import '../model/user.dart';

class UserUtilities {
  static UserModel user = UserModel("Please Login", "000", "Please Register For Account", true);
  static String userProfilePicture = "https://img.icons8.com/?size=512&id=7I3BjCqe9rjG&format=png";

  UserUtilities(UserModel usr, String pfp) {
    user = usr;
    userProfilePicture = pfp;
  }
}
