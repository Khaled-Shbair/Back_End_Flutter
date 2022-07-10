import 'package:get/get.dart';

import '../db_Controller/DB_Controller_User.dart';
import '../models/User.dart';

class UserGet extends GetxController {
  List<User> users = <User>[];
  final DBControllerUser _dbControllerUser = DBControllerUser();

  static UserGet get to => Get.find();

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

  Future<bool> updateUser(User user) async {
    return await _dbControllerUser.update(user);
  }
}
