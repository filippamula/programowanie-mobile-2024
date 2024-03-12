import 'package:flutter/material.dart';
import 'package:jsonplaceholder_app/components/login_button.dart';
import 'package:jsonplaceholder_app/infrastructure/http_client.dart';
import 'package:jsonplaceholder_app/infrastructure/prefs.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

import '../components/login_text_field.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final prefs = StreamingSharedPreferences.instance;
  final client = HttpClient();

  void signInUser() async {
    //todo some progress indicator

    var users = await client.fetchUsers();
    if (users.map((e) => e.email).contains(emailController.text)) {
      prefs.then((prefs) => prefs.setString(USER_EMAIL, emailController.text));
    }

    //todo display error
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigoAccent,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                const Text(
                  '{ }',
                  style: TextStyle(
                      fontSize: 55,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                const SizedBox(height: 50),
                const Text(
                  'Log in',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: LoginTextField(
                        controller: emailController,
                        placeHolder: 'Email',
                        obscureText: false)),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: LoginTextField(
                    controller: passwordController,
                    placeHolder: 'Password',
                    obscureText: true,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: LoginButton(
                      text: 'Sign in',
                      onTap: signInUser,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
