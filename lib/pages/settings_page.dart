import 'package:flutter/material.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  void logout() async {
    var prefs = await StreamingSharedPreferences.instance;
    prefs.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: GestureDetector(
      onTap: logout,
      child: Text('logout'),
    )));
  }
}
