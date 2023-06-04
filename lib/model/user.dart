import 'package:pocketbase/pocketbase.dart';
import 'package:speedlist/Utilities/backend_utilities.dart';
import 'package:speedlist/controller/user_controller.dart';

class UserModel {
  String username;
  String profilePicture;
  String id;
  String email;
  bool isVerified;

  UserModel(this.username, this.profilePicture,this.id, this.email, this.isVerified);

  static Future<UserModel> fromRecord(RecordModel record) async {
    String username = record.getStringValue("username");
    String id = record.id;
    String profilePicture = await UserController.getProfilePictureUrl(BackendUtilities.getBackendAccess(), id);
    String email = record.getStringValue("email");
    bool isVerified = record.getBoolValue("verified");

    return UserModel(username, profilePicture,id, email, isVerified);
  }
}

//You might be wondering why am I not using the UserModel itself.
//Issues arise when we have to confirm user verification and when assigning id.
//These things should be done outside of the application (Id Assigned auto and verification done via email confirmation).
//To make it simpler we use UserRegisterModel.
class UserRegisterModel {
  String username;
  String email;
  List<String> passwords; //Contains both password and confirm password.
  UserRegisterModel(this.username, this.email, this.passwords);
}
