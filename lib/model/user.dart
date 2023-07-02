import 'package:pocketbase/pocketbase.dart';
import 'package:speedlist/Utilities/backend_utilities.dart';
import 'package:speedlist/controller/user_controller.dart';

class UserModel {
  final String id;
  final String username;
  final String profilePicture;
  final String email;
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
  //This method is made for purposes of storing the user to internal database. Check login_view.dart to see implemented code.
  UserForAutoLogin convertToStoreableUser(String pass,bool rememberUser){
    return UserForAutoLogin(userEmailAddress: email, password: pass);
  }
}


//You might be wondering why am I not using the UserModel itself for Register.
//Issues arise when we have to confirm user verification and when assigning id.
//These things should be done outside of the application (Id Assigned auto and verification done via email confirmation).
//To make it simpler we use User.

class User {
  final String username;
  final String userEmailAddress;
  final List<String> passwords; //Contains both password and confirm password.
  User({required this.username, required this.userEmailAddress, required this.passwords});

  //This probably should not be in the production code.
  @override
  String toString() {
    return "$userEmailAddress $passwords[0]";
  }
}

//Split the AutoLoginModel again.
class UserForAutoLogin {
  final int? id;
  final String userEmailAddress;
  final String password;

  UserForAutoLogin({this.id,required this.userEmailAddress, required this.password});

  factory UserForAutoLogin.fromMap(Map<String, dynamic> json) => UserForAutoLogin(
      id: json['id'],
      userEmailAddress: json['userEmailAddress'],
      password: json['password'],
  );

  Map<String, dynamic> toMap() {
    return {
      'id':id,
      'userEmailAddress' :  userEmailAddress,
      'password' : password,
    };
  }

  @override
  String toString() {
    return "$id $userEmailAddress";
  }
}