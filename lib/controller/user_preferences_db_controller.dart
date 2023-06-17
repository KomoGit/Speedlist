import 'dart:io';

import 'package:path_provider/path_provider.dart';
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
    Directory dir = await getApplicationDocumentsDirectory();
    String dirPath = '${dir.path}/speedlist';
    await Directory(dirPath).create(recursive: true);
    final store = await openStore(directory: dirPath);
    return PreferencesDBController._init(store);
  }

  //CRUD Operations.
  Future<int> insertUser(User user) => _userBox.putAsync(user);
  User? getUser(int id) => _userBox.get(id);
  List<User> getAllUsers() => _userBox.getAll();
  bool deleteUser(int id) => _userBox.remove(id);
}