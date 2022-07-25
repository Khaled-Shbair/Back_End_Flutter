import 'package:flutter/material.dart';

import '../../Utils/Helpers.dart';
import '../api/controllers/auth_api_controller.dart';
import '../models/api_response.dart';

class ResetPasswordApiScreen extends StatefulWidget {
  const ResetPasswordApiScreen({Key? key, required this.email})
      : super(key: key);
  final String email;

  @override
  State<ResetPasswordApiScreen> createState() => _ResetPasswordApiScreenState();
}

class _ResetPasswordApiScreenState extends State<ResetPasswordApiScreen>
    with Helpers {
  late TextEditingController _newPasswordEditingController;
  late TextEditingController _newPasswordConfirmationEditingController;
  late TextEditingController _firstCodeTextController;
  late TextEditingController _secondCodeTextController;
  late TextEditingController _thirdCodeTextController;
  late TextEditingController _fourthCodeTextController;
  late FocusNode _firstFocusNode;
  late FocusNode _secondFocusNode;
  late FocusNode _thirdFocusNode;
  late FocusNode _fourthFocusNode;
  String code = '';

  @override
  void initState() {
    super.initState();
    _newPasswordEditingController = TextEditingController();
    _newPasswordConfirmationEditingController = TextEditingController();
    _firstCodeTextController = TextEditingController();
    _secondCodeTextController = TextEditingController();
    _thirdCodeTextController = TextEditingController();
    _fourthCodeTextController = TextEditingController();
    _firstFocusNode = FocusNode();
    _secondFocusNode = FocusNode();
    _thirdFocusNode = FocusNode();
    _fourthFocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _newPasswordEditingController.dispose();
    _newPasswordConfirmationEditingController.dispose();
    _firstCodeTextController.dispose();
    _secondCodeTextController.dispose();
    _thirdCodeTextController.dispose();
    _fourthCodeTextController.dispose();
    _firstFocusNode.dispose();
    _secondFocusNode.dispose();
    _thirdFocusNode.dispose();
    _fourthFocusNode.dispose();
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
          'RESET PASSWORD',
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
            'RESET Password ?',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            'Enter Your code',
            style: TextStyle(
              color: Colors.black45,
              fontSize: 18,
              height: 1,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              FieldInputCode(
                focusNode: _firstFocusNode,
                controller: _firstCodeTextController,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    _secondFocusNode.requestFocus();
                  }
                },
              ),
              const SizedBox(width: 5),
              FieldInputCode(
                focusNode: _secondFocusNode,
                controller: _secondCodeTextController,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    _thirdFocusNode.requestFocus();
                  }
                  _firstFocusNode.requestFocus();
                },
              ),
              const SizedBox(width: 5),
              FieldInputCode(
                focusNode: _thirdFocusNode,
                controller: _thirdCodeTextController,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    _fourthFocusNode.requestFocus();
                  }
                  _secondFocusNode.requestFocus();
                },
              ),
              const SizedBox(width: 5),
              FieldInputCode(
                focusNode: _fourthFocusNode,
                controller: _fourthCodeTextController,
                onChanged: (value) {
                  if (value.isEmpty) {
                    _thirdFocusNode.requestFocus();
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _newPasswordEditingController,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.go,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.lock),
              hintText: 'new password',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.blue.shade300),
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _newPasswordConfirmationEditingController,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.go,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.lock),
              hintText: 'new password confirmation',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.blue.shade300),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async => await _performResetPassword(),
            child: const Text('Reset'),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _performResetPassword() async {
    if (_checkData()) {
      await _resetPassword();
    }
  }

  bool _checkData() {
    if (_checkCode() && _checkPassword()) {
      return true;
    }
    return false;
  }

  bool _checkPassword() {
    if (_newPasswordEditingController.text.isNotEmpty &&
        _newPasswordConfirmationEditingController.text.isNotEmpty) {
      if (_newPasswordEditingController.text ==
          _newPasswordConfirmationEditingController.text) {
        return true;
      } else {
        showSnackBar(context,
            massage: 'Password Confirmation erorr!', erorr: true);
        return false;
      }
    }
    showSnackBar(context, massage: 'Enter new password!', erorr: true);
    return false;
  }

  bool _checkCode() {
    if (_firstCodeTextController.text.isNotEmpty &&
        _secondCodeTextController.text.isNotEmpty &&
        _thirdCodeTextController.text.isNotEmpty &&
        _fourthCodeTextController.text.isNotEmpty) {
      getCode();
      return true;
    }
    showSnackBar(context, massage: 'Enter reset code!', erorr: true);

    return false;
  }

  void getCode() {
    code = _firstCodeTextController.text +
        _secondCodeTextController.text +
        _thirdCodeTextController.text +
        _fourthCodeTextController.text;
  }

  Future<void> _resetPassword() async {
    ApiResponse apiResponse = await AuthApiController().resetPassword(
      email: widget.email,
      code: code,
      password: _newPasswordEditingController.text,
    );
    showSnackBar(context,
        massage: apiResponse.massage, erorr: !apiResponse.status);

    if (apiResponse.status) {
      Navigator.pop(context);
    }
  }
}

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
class FieldInputCode extends StatelessWidget {
  const FieldInputCode({
    Key? key,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
  }) : super(key: key);

  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String value) onChanged;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        textAlign: TextAlign.center,
        keyboardType: const TextInputType.numberWithOptions(
          signed: false,
          decimal: false,
        ),
        onChanged: onChanged,
        maxLength: 1,
        decoration: InputDecoration(
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(width: 1, color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
