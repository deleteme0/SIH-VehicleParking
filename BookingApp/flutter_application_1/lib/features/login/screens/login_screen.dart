import 'package:flutter/material.dart';
import 'package:flutter_application_1/common/widgets/custom_button.dart';
import 'package:flutter_application_1/common/widgets/custom_textfield.dart';
import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

enum Login { signin, signup }

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login-screen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Login _login = Login.signup;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            const Text(
              'Welcome',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 50),
            CustomTextField(controller: _nameController, hintText: "NAME"),
            const SizedBox(height: 50),
            CustomButton(
                text: "LOGIN/SIGNUP",
                onTap: () {
                  print(_nameController);
                  checkLogin(context);
                })
          ]),
        ),
      ),
    );
  }
}

void checkLogin(context) async {
  //var url = Uri.https();
}
