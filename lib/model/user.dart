import 'package:objectbox/objectbox.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:speedlist/Utilities/backend_utilities.dart';
import 'package:speedlist/controller/user_controller.dart';

class UserModel {
  String userEmailAddress;
  String profilePicture;
  String id;
  String email;
  bool isVerified;

  UserModel(this.userEmailAddress, this.profilePicture,this.id, this.email, this.isVerified);

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
  String userEmailAddress;
  String email;
  List<String> passwords; //Contains both password and confirm password.
  UserRegisterModel(this.userEmailAddress, this.email, this.passwords);
}

// This model is used for purposes of saving users info on the app itself.
// It is a model made only for ObjectBox.
@Entity()
@Sync()
class User{
  int id;
  String email;
  String password;

  User({
    this.id = 0 ,
    required this.email,
    required this.password}
      );
}
