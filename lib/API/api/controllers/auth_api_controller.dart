/*
 عمليات المصادقة على تسجيل الدخول و تسجيل الخروج المسجلين في API
 ويتم من خلال حغظ Token في SharedPrefController
  */
import 'dart:convert';
import 'dart:io';

import 'package:data_base/API/api/Api_setting.dart';
import 'package:data_base/API/models/student.dart';
import 'package:data_base/API/storage/shared_pref_controller.dart';
import 'package:http/http.dart' as http;

import '../../models/api_response.dart';

class AuthApiController {
  Future<ApiResponse> login(
      {required String email, required String password}) async {
    var url = Uri.parse(ApiSetting.login);
    var response =
        await http.post(url, body: {'email': email, 'password': password});
    if (response.statusCode == 200 || response.statusCode == 400) {
      var jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        var jsonObject = jsonResponse['object'];
        Student student = Student.fromJson(jsonObject);
        SharedPrefController().save(student: student);
      }
      return ApiResponse(
        massage: jsonResponse['message'],
        status: jsonResponse['status'],
      );
    } else {
      return ApiResponse(
        massage: 'Something went wrong, try again',
        status: false,
      );
    }
  }

  Future<ApiResponse> logout() async {
    var url = Uri.parse(ApiSetting.logout);
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: SharedPrefController().token,
      HttpHeaders.acceptHeader: 'application/json'
    });
    if (response.statusCode == 200 || response.statusCode == 401) {
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return ApiResponse(
            massage: jsonResponse['message'], status: jsonResponse['status']);
      } else {
        return ApiResponse(massage: 'Logout successfully', status: true);
      }
    }
    return ApiResponse(
        massage: 'Something went wrong, try again', status: false);
  }

  Future<ApiResponse> register({required Student student}) async {
    var url = Uri.parse(ApiSetting.register);
    var response = await http.post(url, body: {
      'full_name': student.fullName,
      'email': student.email,
      'password': student.password,
      'gender': student.gender,
    });
    if (response.statusCode == 201 || response.statusCode == 400) {
      var jsonResponse = jsonDecode(response.body);
      return ApiResponse(
          massage: jsonResponse['message'], status: jsonResponse['status']);
    }
    return ApiResponse(
        massage: 'Something went wrong, try again', status: false);
  }
}
