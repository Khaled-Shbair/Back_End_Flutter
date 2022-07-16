import 'package:flutter/material.dart';

import '../storage/shared_pref_controller.dart';

class LunchApiScreen extends StatefulWidget {
  const LunchApiScreen({Key? key}) : super(key: key);

  @override
  State<LunchApiScreen> createState() => _LunchApiScreenState();
}

class _LunchApiScreenState extends State<LunchApiScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      String route =
          SharedPrefController().login ? '/UserScreen' : '/LoginApiScreen';
      Navigator.pushReplacementNamed(context, route);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'API APP',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
