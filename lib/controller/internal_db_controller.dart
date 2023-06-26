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
      CREATE TABLE userInfo(
        email TEXT,
        password TEXT
      )
    ''');
  }
}