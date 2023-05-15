import 'package:pocketbase/pocketbase.dart';
import 'package:speedlist/Utilities/login_utilities.dart';
import 'package:speedlist/model/user.dart';

import '../debug/print.dart';

class UserController {
  static LoginUtilities loginUtilities = LoginUtilities();
  static Future<UserModel> authUser(
      PocketBase pb, String usernameoremail, password) async {
    late RecordAuth authData;
    try {
      authData = await pb
          .collection('users')
          .authWithPassword(usernameoremail, password)
          .timeout(const Duration(seconds: 10));
    } catch (e) {
      Debug.printLog(e);
    }
    return UserModel.fromRecord(authData.record!);
  }

  //We might require a bool to return incase something goes wrong?
  static Future<String> requestUserPasswordReset(
      PocketBase pb, String email) async {
    try {
      await pb.admins.requestPasswordReset(email);
    } catch (e) {
      Debug.printLog(e);
      return e.toString();
    }
    return "Please check your email for further instructions.";
  }

  static Future<String> createNewUser(
      PocketBase pb, UserRegisterModel user) async {
    final body = <String, dynamic>{
      "username": user.username,
      "email": user.email,
      "emailVisibility": false,
      "password": user.passwords[0],
      "passwordConfirm": user.passwords[1]
    };
    try {
      await pb.collection('users').create(body: body);
    } catch (e) {
      return loginUtilities.formatErrorMessage(e.toString());
    }
    return "Registration succesful, confirm your account by checking your email.";
  }
}
