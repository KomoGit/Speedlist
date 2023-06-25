import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:speedlist/model/user.dart';
import 'package:speedlist/objectbox.g.dart';


//Uses Objectbox.
class InternalDBController
{
  late final Store _store;
  late final Box<User> _userBox;

  InternalDBController._init(this._store){
    _userBox = Box<User>(_store);
  }

  static Future<InternalDBController> init() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String dirPath = '${dir.path}/speedlist';
    await Directory(dirPath).create(recursive: true);
    final store = await openStore(directory: dirPath);
    return InternalDBController._init(store);
  }

  //CRUD Operations.
  int? insertUser(User usr) => _userBox.put(usr);
  int? deleteAll() => _userBox.removeAll();
  User? getUser(int id) => _userBox.get(id);
  List<User> getAllUsers() => _userBox.getAll();
  bool deleteUser(int id) => _userBox.remove(id);
}

class DBAccess{
  late InternalDBController dbController;

  static Future<InternalDBController> initInternalDB() async{
    return await InternalDBController.init();
  }
}