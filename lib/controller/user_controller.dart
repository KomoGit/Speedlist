import 'package:pocketbase/pocketbase.dart';
import 'package:speedlist/model/user.dart';

class UserController {
  // static Future<bool> attemptLogin(
  //     PocketBase pb, String usernameoremail, String password) async {
  //   final authData = await pb
  //       .collection('users')
  //       .authWithPassword(usernameoremail, password);
  //   return authData.record!.getBoolValue("verified");
  // }

  static Future<UserModel> authUser(
      PocketBase pb, String usernameoremail, password) async {
    final authData = await pb
        .collection('users')
        .authWithPassword(usernameoremail, password);
    return UserModel.fromModel(authData.record!);
  }
}
