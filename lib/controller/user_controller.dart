import 'package:pocketbase/pocketbase.dart';
import 'package:speedlist/Utilities/login_utilities.dart';
import 'package:speedlist/model/user.dart';


class UserController {
  static final LoginUtilities _loginUtilities = LoginUtilities();

  static Future<UserModel> auth(
      PocketBase pb, String email, String password) async {
    late RecordAuth authData;
    try {
      authData = await pb
          .collection('users')
          .authWithPassword(email, password)
          .timeout(const Duration(seconds: 10));
      return UserModel.fromRecord(authData.record!);
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<String> requestPasswordReset(
      PocketBase pb, String email) async {
    try {
      await pb.admins
          .requestPasswordReset(email)
          .timeout(const Duration(seconds: 10),);
    } catch (e) {
      return e.toString();
    }
    return "Please check your email for further instructions.";
  }

  static Future<String> createNewUser(
      PocketBase pb, UserRegisterModel user) async {
    final body = <String, dynamic>{
      "username": user.userEmailAddress,
      "email": user.email,
      "emailVisibility": false,
      "password": user.passwords[0],
      "passwordConfirm": user.passwords[1]
    };
    try {
      await pb
          .collection('users')
          .create(body: body)
          .timeout(const Duration(seconds: 10));
    } catch (e) {
      return _loginUtilities.formatErrorMessage(e.toString());
    }
    return "Registration successful, confirm your account by checking your email.";
  }

  static Future<UserModel> getUserById(PocketBase pb, String id) async{
    List<RecordModel> rawData = await pb
        .collection('categories')
        .getFullList()
        .timeout(const Duration(seconds: 10),
    );
    for (RecordModel model in rawData) {
      if(model.id == id){
        return UserModel.fromRecord(model);
      }
    }
    throw Exception("User with specified ID could not be found");
  }

  //This is one of those temporary measures. Yes that type......it will stay here for a while.
  static Future<String> getProfilePictureUrl(
      PocketBase pb, id) async {
    //What you see in collection() is the id of user collection in PocketBase. I had to hard code that in there. It is a safety issue but will do now...I sound like those youtube videos
    final RecordModel record =
        await pb.collection('gr29v07m0ysyep8').getOne(id);
    return pb
        .getFileUrl(record, record.getStringValue('profilepicture'))
        .toString();
  }
}
