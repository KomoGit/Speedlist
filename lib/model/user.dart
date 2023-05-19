import 'package:pocketbase/pocketbase.dart';

class UserModel {
  String username;
  String id;
  String profilePicture;
  String email;
  bool isVerified;

  UserModel(
      this.username, this.id, this.profilePicture, this.email, this.isVerified);

  static UserModel fromRecord(RecordModel model) {
    String username = model.getStringValue("username");
    String id = model.id;
    String profilePicture = model.getStringValue("profilepicture");
    String email = model.getStringValue("email");
    bool isVerified = model.getBoolValue("verified");

    return UserModel(username, id, email, profilePicture, isVerified);
  }
}

//You might be wondering why am I not using the UserModel itself.
//Issues arise when we have to confirm user verification and when assinging id.
//These things should be done outside of the application (Id Assigned auto and verification done via email confirmation).
//To make it simpler we use UserRegisterModel.
class UserRegisterModel {
  String username;
  String email;
  List<String> passwords; //Contains both password and confirm password.
  UserRegisterModel(this.username, this.email, this.passwords);
}
