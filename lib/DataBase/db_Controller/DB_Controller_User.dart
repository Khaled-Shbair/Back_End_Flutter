import 'package:data_base/Storage/Pref_Controller.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/User.dart';
import '../DB_Controller.dart';
import '../DB_Operations.dart';

class DBControllerUser implements DBOperation<User> {
  Database database = DBController().dataBase;

  Future<bool> login({required String email, required String password}) async {
    List<Map<String, dynamic>> maps = await database.query('users',
        where: 'email = ? AND password = ?', whereArgs: [email, password]);
    if (maps.isNotEmpty) {
      User user = User.fromMap(maps.first);
      await PrefController().save(user);
    }
    return maps.isNotEmpty;
  }

  @override
  Future<int> create(User user) async {
    int newRowId = await database.insert('users', user.toMap());
    return newRowId;
  }

  @override
  Future<bool> delete(int id) async {
    int countOfDeletedRows =
        await database.delete('users', where: 'id = ?', whereArgs: [id]);
    return countOfDeletedRows == 1;
  }

  @override
  Future<List<User>> read() async {
    List<Map<String, dynamic>> rows =
        await database.query('users'); //columns: ['id','name'],
    List<User> user = rows
        .map((Map<String, dynamic> rowMap) => User.fromMap(rowMap))
        .toList();
    return user;
  }

  @override
  Future<User?> show(int id) async {
    List<Map<String, dynamic>> rows =
        await database.query('users', where: 'id = ?', whereArgs: [id]);
    if (rows.isNotEmpty) {
      return User.fromMap(rows.first);
    }
    return null;
  }

  @override
  Future<bool> update(User user) async {
    int countOfUpdatedRows = await database
        .update('users', user.toMap(), where: 'id = ?', whereArgs: [user.id]);
    return countOfUpdatedRows == 1;
  }
}
