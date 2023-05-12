import 'package:pocketbase/pocketbase.dart';
import 'package:speedlist/model/user.dart';

class UserController {
  static Future<UserModel> authUser(
      PocketBase pb, String usernameoremail, password) async {
    final authData = await pb
        .collection('users')
        .authWithPassword(usernameoremail, password)
        .timeout(const Duration(seconds: 10));
    return UserModel.fromModel(authData.record!);
  }

  //We might require a bool to return incase something goes wrong?
  static Future<void> requestUserPasswordReset(
      PocketBase pb, String email) async {
    await pb.admins.requestPasswordReset(email);
  }

  static Future<void> createNewUser(PocketBase pb, UserModel user) async {
    final body = <String, dynamic>{
      "username": user.username,
      "email": user.email,
      "emailVisibility": false,
      "password": user.password,
      "passwordConfirm": "12345678"
    };
    await pb.collection('users').create(body: body);
    //await pb.collection('users').requestVerification(user.email); Haven't configured that yet so.
  }
}
