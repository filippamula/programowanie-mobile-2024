import 'package:flutter/material.dart';
import 'package:jsonplaceholder_app/pages/albums_page.dart';
import 'package:jsonplaceholder_app/pages/posts_page.dart';
import 'package:jsonplaceholder_app/pages/settings_page.dart';
import 'package:jsonplaceholder_app/pages/todos_page.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class NavBarPage extends StatefulWidget {
  const NavBarPage({super.key});

  void logout() async {
    var prefs = await StreamingSharedPreferences.instance;
    prefs.clear();
  }

  @override
  State<StatefulWidget> createState() => _NavBarState();
}

class _NavBarState extends State<NavBarPage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: NavigationBar(
            onDestinationSelected: (int index) {
              setState(() {
                currentPageIndex = index;
              });
            },
            selectedIndex: currentPageIndex,
            destinations: const <Widget>[
              NavigationDestination(
                  selectedIcon:
                      Icon(Icons.post_add, color: Colors.indigoAccent),
                  icon: Icon(Icons.post_add),
                  label: 'Posts'),
              NavigationDestination(
                  selectedIcon: Icon(Icons.photo, color: Colors.indigoAccent),
                  icon: Icon(Icons.photo),
                  label: 'Albums'),
              NavigationDestination(
                  selectedIcon: Icon(Icons.check, color: Colors.indigoAccent),
                  icon: Icon(Icons.check),
                  label: 'Todos'),
              NavigationDestination(
                  selectedIcon:
                      Icon(Icons.settings, color: Colors.indigoAccent),
                  icon: Icon(Icons.settings),
                  label: 'Settings')
            ]),
        body: <Widget>[
          const PostsPage(),
          const AlbumsPage(),
          const TodosPage(),
          const SettingsPage()
        ][currentPageIndex]);
  }
}
