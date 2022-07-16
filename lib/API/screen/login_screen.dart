import 'package:flutter/material.dart';

import '../../Utils/Helpers.dart';
import '../api/controllers/auth_api_controller.dart';
import '../models/api_response.dart';

class LoginApiScreen extends StatefulWidget {
  const LoginApiScreen({Key? key}) : super(key: key);

  @override
  State<LoginApiScreen> createState() => _LoginApiScreenState();
}

class _LoginApiScreenState extends State<LoginApiScreen> with Helpers {
  late TextEditingController _emailEditingController;
  late TextEditingController _passwordEditingController;

  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _emailEditingController = TextEditingController();
    _passwordEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailEditingController.dispose();
    _passwordEditingController.dispose();
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
          'LOGIN',
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
            'Welcome back...',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            'Login to start using app',
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
          const SizedBox(height: 10),
          TextField(
            controller: _passwordEditingController,
            keyboardType: TextInputType.visiblePassword,
            obscureText: _obscureText,
            textInputAction: TextInputAction.go,
            onSubmitted: (value) async {
              await _performLogin();
            },
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _obscureText != _obscureText;
                  });
                },
                icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off),
              ),
              hintText: 'Password',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.blue.shade300),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/ForgetPasswordApiScreen');
                },
                child: const Text(
                  'Forget password?',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                )),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async => await _performLogin(),
            child: const Text('Login'),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
          ),
          Row(
            children: [
              const Text(
                'Dont\'n have an account',
                style: TextStyle(
                  color: Colors.black45,
                  fontWeight: FontWeight.w300,
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/RegisterApiScreen');
                  },
                  child: const Text(
                    'Create now!',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _performLogin() async {
    if (_checkData()) {
      await _login();
    }
  }

  bool _checkData() {
    if (_emailEditingController.text.isNotEmpty &&
        _passwordEditingController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context, massage: 'Enter required data!', erorr: true);
    return false;
  }

  Future<void> _login() async {
    ApiResponse apiResponse = await AuthApiController().login(
        email: _emailEditingController.text,
        password: _passwordEditingController.text);
    showSnackBar(context,
        massage: apiResponse.massage, erorr: !apiResponse.status);

    if (apiResponse.status) {
      Navigator.pushReplacementNamed(context, '/UserScreen');
    }
  }
}
