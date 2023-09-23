import 'package:flutter/material.dart';
import 'package:flutter_application_1/common/widgets/custom_button.dart';
import 'package:flutter_application_1/common/widgets/custom_textfield.dart';

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
            const SizedBox(height: 10),
            ListTile(
              tileColor: _login == Login.signup ? Colors.white : Colors.grey,
              title: const Text(
                "create account",
                style: TextStyle(fontWeight: FontWeight.w300),
              ),
              leading: Radio(
                activeColor: Colors.amber,
                value: Login.signup,
                groupValue: _login,
                onChanged: (Login? val) {
                  setState(() {
                    _login = val!;
                  });
                },
              ),
            ),
            if (_login == Login.signup)
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _signUpFormKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: _nameController,
                        hintText: "name",
                      ),
                      CustomButton(
                        onTap: () {},
                        text: "submit",
                      )
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 10),
            ListTile(
              title: const Text(
                "sign in to your account",
                style: TextStyle(fontWeight: FontWeight.w300),
              ),
              leading: Radio(
                activeColor: Colors.amber,
                value: Login.signin,
                groupValue: _login,
                onChanged: (Login? val) {
                  setState(() {
                    _login = val!;
                  });
                },
              ),
            )
          ]),
        ),
      ),
    );
  }
}
