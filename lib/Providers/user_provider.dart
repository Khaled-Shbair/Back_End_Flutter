import 'package:flutter/material.dart';

import '../DataBase/db_Controller/DB_Controller_User.dart';
import '../models/User.dart';

class UserProvider extends ChangeNotifier {
  List<User> users = <User>[];
  final DBControllerUser _dbControllerUser = DBControllerUser();

  Future<bool> login({required String email, required String password}) async {
    return await _dbControllerUser.login(email: email, password: password);
  }

  Future<bool> create(User user) async {
    int newRowId = await _dbControllerUser.create(user);
    return newRowId != 0;
  }

  Future<bool> delete(int index) async {
    return await _dbControllerUser.delete(users[index].id);
  }

  Future<bool> update(User user) async {
    return await _dbControllerUser.update(user);
  }
}
