import 'dart:convert';
import 'package:data_base/API/models/Base_Api_Response.dart';
import 'package:data_base/API/models/user.dart';
import '../Api_setting.dart';
import 'package:http/http.dart' as http;

class UserApiController {
  Future<List<User>> readUsers() async {
    var url = Uri.parse(ApiSetting.readUser);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      /** في حال كنت بدي اقرا json كلها **/
      //BaseApiResponse baseApiResponse = BaseApiResponse.fromJson(jsonResponse);
      //return baseApiResponse.data;

      /** في حال كنت بدي اقرا جزء معين من البيانات فقط والباقي ما يلزمني**/
      var dataJsonArray = jsonResponse['data'] as List;
      List<User> _users = dataJsonArray
          .map((userJsonObjectMap) => User.fromJson(userJsonObjectMap))
          .toList();
      return _users;
    }
    return [];
  }
}
