import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/user.dart';

class HttpClient {
  static const String url = 'https://jsonplaceholder.typicode.com';
  static const String fetchUsersPath = '/users';

  Future<List<User>> fetchUsers() async {
    final uri = Uri.parse(url + fetchUsersPath);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      List<User> users = [];
      for (var user in jsonDecode(response.body)) {
        users.add(User.fromJson(user));
      }
      return users;
    }
    throw Exception('Failed to fetch users');
  }
}
