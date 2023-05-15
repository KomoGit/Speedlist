import 'package:pocketbase/pocketbase.dart';

class UserModel {
  String username;
  String id;
  String email;
  bool isVerified;

  UserModel(
      this.username, this.id, this.email, /*this.password,*/ this.isVerified);

  static UserModel fromRecord(RecordModel model) {
    String username = model.getStringValue("username");
    String id = model.id;
    String email = model.getStringValue("email");
    bool isVerified = model.getBoolValue("verified");

    return UserModel(username, id, email, isVerified);
  }
}

class UserRegisterModel {
  String username;
  String email;
  String pass;
  String pass2;

  UserRegisterModel(this.username, this.email, this.pass, this.pass2);
}
