import 'package:shared_preferences/shared_preferences.dart';

import '../models/User.dart';

enum prefKeys { id, password, email, login }

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
    await _sharedPreferences.setString(prefKeys.email.toString(), user.email);
    await _sharedPreferences.setString(
        prefKeys.password.toString(), user.password);
    await _sharedPreferences.setInt(prefKeys.id.toString(), user.id);
    await _sharedPreferences.setBool(prefKeys.login.toString(), true);
  }

  bool get login =>
      _sharedPreferences.getBool(prefKeys.login.toString()) ?? false;

  Future<bool> clear() async => await _sharedPreferences.clear();

  T? getKey<T>({required String key}) {
    return _sharedPreferences.get(key) as T;
  }

//T? getKeyNew<T>({required String key})=>_sharedPreferences.get(key) as T;

}
