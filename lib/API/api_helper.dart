import 'dart:io';

import 'package:data_base/API/storage/shared_pref_controller.dart';

mixin ApiHelper {
  Map<String, String> get headers {
    Map<String, String> headers = <String, String>{};
    headers[HttpHeaders.acceptHeader] = 'application/json';
    if (SharedPrefController().login) {
      headers[HttpHeaders.authorizationHeader] = SharedPrefController().token;
    }
    return headers;
  }
}
