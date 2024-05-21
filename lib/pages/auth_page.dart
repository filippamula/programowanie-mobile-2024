import 'package:flutter/material.dart';
import 'package:jsonplaceholder_app/infrastructure/prefs.dart';
import 'package:jsonplaceholder_app/pages/login_page.dart';
import 'package:jsonplaceholder_app/pages/nav_bar_page.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  Future<Stream<int>> getLoggedUserEmail() async {
    var prefs = await StreamingSharedPreferences.instance;
    return prefs.getInt(USER_ID, defaultValue: -1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: getLoggedUserEmail(),
            builder: (context, snapshot) {
              return StreamBuilder<int>(
                  stream: snapshot.data,
                  builder: (context, snapshot) {
                    if (snapshot.data == -1 || snapshot.data == null) {
                      return const LoginPage();
                    }
                    return const NavBarPage();
                  });
            }));
  }
}
