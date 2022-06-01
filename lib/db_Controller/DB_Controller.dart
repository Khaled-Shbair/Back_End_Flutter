import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBController {
  static final DBController _instance = DBController._();
  late Database _database;

  DBController._();

  factory DBController() {
    return _instance;
  }

  Future<void> initDataBase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'db.sql');
    _database = await openDatabase(
      path,
      version: 1,
      onOpen: (Database db) {},
      onCreate: (Database db, int version) async {
        await db.execute('CREATE TABLE users ('
            'id INTEGER PRIMARY KEY AUTOINCREMENT,'
            'name TEXT,'
            'email TEXT,'
            'password TEXT'
            ')');
        await db.execute('CREATE TABLE notes ('
            'id INTEGER PRIMARY KEY AUTOINCREMENT,'
            'title TEXT,'
            'details TEXT,'
            'user_id INTEGER FOREIGN KEY REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE'
            ')');
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) {},
      onDowngrade: (Database db, int oldVersion, int newVersion) {},
    );
  }
}
