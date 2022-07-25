import 'package:data_base/API/screen/reset_password_screen.dart';
import 'package:flutter/material.dart';

import '../../Utils/Helpers.dart';
import '../api/controllers/auth_api_controller.dart';
import '../models/api_response.dart';

class ForgetPasswordApiScreen extends StatefulWidget {
  const ForgetPasswordApiScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordApiScreen> createState() =>
      _ForgetPasswordApiScreenState();
}

class _ForgetPasswordApiScreenState extends State<ForgetPasswordApiScreen>
    with Helpers {
  late TextEditingController _emailEditingController;

  @override
  void initState() {
    super.initState();
    _emailEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.black,
        title: const Text(
          'FORGET PASSWORD',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsetsDirectional.all(20),
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const Text(
            'Forget Password ?',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            'Enter email to sent code',
            style: TextStyle(
              color: Colors.black45,
              fontSize: 18,
              height: 1,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _emailEditingController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.mail),
              hintText: 'Email',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.blue.shade300),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async => await _performForgetPassword(),
            child: const Text('Send'),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _performForgetPassword() async {
    if (_checkData()) {
      await _forgetPassword();
    }
  }

  bool _checkData() {
    if (_emailEditingController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context, massage: 'Enter required data!', erorr: true);
    return false;
  }

  Future<void> _forgetPassword() async {
    ApiResponse apiResponse = await AuthApiController()
        .forgetPassword(email: _emailEditingController.text);
    showSnackBar(context,
        massage: apiResponse.massage, erorr: !apiResponse.status);
    if (apiResponse.status) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResetPasswordApiScreen(
            email: _emailEditingController.text,
          ),
        ),
      );
    }
  }
}
