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
  //This method is made for purposes of storing the user to internal database. Check login_view.dart to see implemented code.
  User convertToStoreableUser(String pass){
    List<String> password = [];
    password.add(pass);
    return User(username: "",userEmailAddress: userEmailAddress,passwords: password);
  }
}


//You might be wondering why am I not using the UserModel itself.
//Issues arise when we have to confirm user verification and when assigning id.
//These things should be done outside of the application (Id Assigned auto and verification done via email confirmation).
//To make it simpler we use User.

@Entity()
class User {
  @Id()
  int id; // Id you see here != id of UserModel. This id is simply here for internal nosql db.
  String username;
  String userEmailAddress; //Both email and username are same.
  List<String> passwords; //Contains both password and confirm password.
  User({this.id = 0, required this.username, required this.userEmailAddress, required this.passwords});

  @override
  String toString() {
    return "$userEmailAddress $passwords[0]";
  }
}