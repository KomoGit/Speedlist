import 'package:pocketbase/pocketbase.dart';

class UserModel {
  String username;
  String id;
  String email;
  String password;
  bool isVerified;

  UserModel(this.username, this.id, this.email, this.password, this.isVerified);

  static UserModel fromModel(RecordModel model) {
    String username = model.getStringValue("username");
    String id = model.id;
    String email = model.getStringValue("email");
    String password = model.getStringValue("password");
    bool isVerified = model.getBoolValue("verified");

    return UserModel(username, id, email, password, isVerified);
  }
}
