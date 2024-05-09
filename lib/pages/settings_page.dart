import 'package:flutter/material.dart';
import 'package:jsonplaceholder_app/infrastructure/http_client.dart';
import 'package:jsonplaceholder_app/infrastructure/prefs.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final client = HttpClient();
  var userName = '';

  void logout() async {
    var prefs = await StreamingSharedPreferences.instance;
    prefs.clear();
  }

  void setLoggedUser() async {
    final prefs = await StreamingSharedPreferences.instance;
    final loggedUserId = prefs.getString(USER_ID, defaultValue: '').getValue();
    client.fetchUser(loggedUserId).then((value) => setState(() {
          userName = value.name;
        }));
  }

  @override
  Widget build(BuildContext context) {
    if (userName == '') {
      setLoggedUser();
    }
    return SafeArea(
        child: Column(
      children: [
        Container(
          decoration: const BoxDecoration(
              border:
                  Border(bottom: BorderSide(width: 0.5, color: Colors.grey))),
          child: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(100)),
                  child: const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Icon(
                      Icons.person,
                      size: 50,
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Text(userName)
              ],
            ),
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            logout();
          },
          child: Container(
            decoration: const BoxDecoration(
                border:
                    Border(top: BorderSide(width: 0.5, color: Colors.grey))),
            child: const Padding(
              padding: EdgeInsets.all(13.0),
              child: Row(
                children: [
                  Text(
                    'Logout',
                    style: TextStyle(
                        color: Colors.redAccent, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    ));
  }
}
