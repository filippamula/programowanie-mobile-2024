import 'package:flutter/material.dart';
import 'package:jsonplaceholder_app/components/login_button.dart';
import 'package:jsonplaceholder_app/infrastructure/http_client.dart';
import 'package:jsonplaceholder_app/infrastructure/prefs.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

import '../components/login_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final prefs = StreamingSharedPreferences.instance;

  final client = HttpClient();

  var errorMessage = '';

  Future signInUser() async {
    try {
      var users = await client.fetchUsers();
      var user = users
          .where((e) => e.email == emailController.text.toLowerCase())
          .first;
      prefs.then((prefs) => prefs.setInt(USER_ID, user.id));
    } catch (exception) {
      showError('Error occurred');
    }

    // prefs.then(
    //     (prefs) => prefs.setInt(USER_ID, 1)); //todo: delete workaround !!
  }

  void showError(String message) {
    setState(() {
      errorMessage = message;
    });
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
                    fontWeight: FontWeight.bold,
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
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: SizedBox(
                        height: 30,
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(errorMessage,
                              style: TextStyle(
                                color: Colors.orange.shade300,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ),
                    ),
                  ],
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
