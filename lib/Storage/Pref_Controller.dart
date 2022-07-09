import 'package:shared_preferences/shared_preferences.dart';

import '../DataBase/models/User.dart';

enum PrefKeys { id, password, email, login }

class PrefController {
  static final PrefController _prefController = PrefController._();
  late SharedPreferences _sharedPreferences;

  PrefController._();

  factory PrefController() {
    return _prefController;
  }

  Future<void> initPrefController() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> save(User user) async {
    await _sharedPreferences.setString(PrefKeys.email.toString(), user.email);
    await _sharedPreferences.setString(
        PrefKeys.password.toString(), user.password);
    await _sharedPreferences.setInt(PrefKeys.id.toString(), user.id);
    await _sharedPreferences.setBool(PrefKeys.login.toString(), true);
  }

  bool get login =>
      _sharedPreferences.getBool(PrefKeys.login.toString()) ?? false;

  Future<bool> clear() async => await _sharedPreferences.clear();

  T? getKey<T>({required String key}) {
    return _sharedPreferences.get(key) as T;
  }

//T? getKeyNew<T>({required String key})=>_sharedPreferences.get(key) as T;

}
