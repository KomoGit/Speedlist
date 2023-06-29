import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:speedlist/model/user.dart';
import 'package:sqflite/sqflite.dart';


class InternalDBController{
  InternalDBController._privateConstructor();
  //Singleton.
  static final InternalDBController instance  = InternalDBController._privateConstructor();

  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async{
    Directory dir = await getApplicationDocumentsDirectory();
    String dirPath = '${dir.path}/user.db';
    return await openDatabase(
      dirPath,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async{
    await db.execute('''
      CREATE TABLE "userInfo"(
        id INTEGER PRIMARY KEY,
        userEmailAddress TEXT,
        password TEXT
      )''');
  }

  Future<UserForAutoLogin> getUserFromMemory() async{
    final Database db = await instance.database;
    var user = await db.query('userInfo');
    if(user[0].isNotEmpty){
      return UserForAutoLogin.fromMap(user[0]);
    }
    throw Exception("No users in database.");
  }

  Future<int> addUserToMemory(UserForAutoLogin usr) async{
    Database db = await instance.database;
    return await db.insert('userInfo', usr.toMap());
  }

  Future<int> removeAllFromMemory() async{
    Database db = await instance.database;
    return await db.delete('userInfo');
  }
}