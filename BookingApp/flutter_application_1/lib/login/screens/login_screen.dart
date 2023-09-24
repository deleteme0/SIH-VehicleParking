// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_application_1/booking-screen.dart';
import 'package:flutter_application_1/common/widgets/custom_button.dart';
import 'package:flutter_application_1/common/widgets/custom_textfield.dart';
import 'package:flutter_application_1/my-spots-screen.dart';
import 'package:flutter_application_1/services/userService.dart';
import 'package:flutter_application_1/services/bookingService.dart';
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
  final TextEditingController _emailController = TextEditingController();

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
            CustomTextField(
                controller: _passwordController, hintText: "password"),
            CustomTextField(controller: _emailController, hintText: "email"),
            const SizedBox(height: 50),
            CustomButton(
                text: "LOGIN/SIGNUP",
                onTap: () async {
                  if (await checkLogin(context, _nameController)) {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            //builder: (context) => BookingScreen(),
                            builder: (context) => MySpotsScreen()));
                  }
                }),
          ]),
        ),
      ),
    );
  }
}

Future<bool> checkLogin(context, _name) async {
  print(_name.text);
  if (await getUserLogin(_name.text)) {
    print("success");
    print(getId());

    await getSpots();

    return true;
  }
  return false;
}
