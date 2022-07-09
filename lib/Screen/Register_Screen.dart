import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../DataBase/Providers/user_provider.dart';
import '../Utils/Helpers.dart';
import '../DataBase/models/User.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with Helpers {
  late TextEditingController _emailEditingController;
  late TextEditingController _passwordEditingController;
  late TextEditingController _nameEditingController;

  @override
  void initState() {
    super.initState();
    _emailEditingController = TextEditingController();
    _passwordEditingController = TextEditingController();
    _nameEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _emailEditingController.dispose();
    _passwordEditingController.dispose();
    _nameEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'REGISTER',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const Text(
            'Create Account...',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          const Text(
            'Enter new Account info',
            style: TextStyle(
              color: Colors.black45,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            keyboardType: TextInputType.emailAddress,
            controller: _emailEditingController,
            decoration: InputDecoration(
              hintText: 'Email',
              prefixIcon: const Icon(Icons.email),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  width: 1,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            controller: _passwordEditingController,
            decoration: InputDecoration(
              hintText: 'password',
              prefixIcon: const Icon(Icons.lock),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  width: 1,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            keyboardType: TextInputType.name,
            controller: _nameEditingController,
            decoration: InputDecoration(
              hintText: 'name',
              prefixIcon: const Icon(Icons.person),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  width: 1,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
              onPressed: () => performRegister(),
              child: const Text('REGISTER')),
        ],
      ),
    );
  }

  Future<void> performRegister() async {
    if (checkData()) {
      await register();
    }
  }

  bool checkData() {
    if (_emailEditingController.text.isNotEmpty &&
        _passwordEditingController.text.isNotEmpty &&
        _nameEditingController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context, massage: 'Enter required data', erorr: true);
    return false;
  }

  Future<void> register() async {
    bool login = await Provider.of<UserProvider>(context,listen: false).create(user);
    if (login) {
      Navigator.pop(context);
    }
  }

  User get user {
    User user = User();
    user.name = _nameEditingController.text;
    user.email = _emailEditingController.text;
    user.password = _passwordEditingController.text;
    return user;
  }
}
