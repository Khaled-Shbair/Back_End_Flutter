import 'package:data_base/API/models/student.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum PrefKey { login, id, fullName, email, gender, token }

class SharedPrefController {
  static final SharedPrefController _prefController = SharedPrefController._();
  late SharedPreferences _sharedPreferences;

  SharedPrefController._();

  factory SharedPrefController() {
    return _prefController;
  }

  Future<void> initSharedPref() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> save({required Student student}) async {
    await _sharedPreferences.setBool(PrefKey.login.toString(), true);
    await _sharedPreferences.setInt(PrefKey.id.toString(), student.id);
    await _sharedPreferences.setString(
        PrefKey.fullName.toString(), student.fullName);
    await _sharedPreferences.setString(PrefKey.email.toString(), student.email);
    await _sharedPreferences.setString(
        PrefKey.gender.toString(), student.gender);
    await _sharedPreferences.setString(
        PrefKey.token.toString(), 'Bearer${student.token}');
  }

  bool get login =>
      _sharedPreferences.getBool(PrefKey.login.toString()) ?? false;

  String get token =>
      _sharedPreferences.getString(PrefKey.token.toString()) ?? '';

  Future<bool> clear() async => _sharedPreferences.clear();
}
