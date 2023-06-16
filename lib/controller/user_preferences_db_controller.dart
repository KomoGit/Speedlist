import 'package:speedlist/model/user.dart';
import 'package:speedlist/objectbox.g.dart';

class PreferencesDBController
{
  late final Store _store;
  late final Box<User> _userBox;

  PreferencesDBController._init(this._store){
    _userBox = Box<User>(_store);
  }

  static Future<PreferencesDBController> init() async {
    final store = await openStore(); //Tutorial shows that this operation is indeed a future operation. Try removing this once you ensure this code works.
    return PreferencesDBController._init(store);
  }
  //CRUD Operations.
  int insertUser(User user) => _userBox.put(user);
  User? getUser(int id) => _userBox.get(id);
  bool deleteUser(int id) => _userBox.remove(id);
}