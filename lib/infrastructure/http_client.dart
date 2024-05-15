import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jsonplaceholder_app/model/comment.dart';
import 'package:jsonplaceholder_app/model/post.dart';

import '../model/user.dart';

class HttpClient {
  static const String url = 'https://jsonplaceholder.typicode.com';
  static const String fetchUsersPath = '/users';
  static const String fetchPostsPath = '/posts';
  static const String fetchCommentsPath = '/comments';

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

  Future<User> fetchUser(String id) async {
    final uri = Uri.parse("$url$fetchUsersPath/$id");
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    }
    throw Exception('Failed to fetch user');
  }

  Future<List<Post>> fetchPosts() async {
    final uri = Uri.parse(url + fetchPostsPath);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      List<Post> posts = [];
      for (var post in jsonDecode(response.body)) {
        posts.add(Post.fromJson(post));
      }
      return posts;
    }
    throw Exception('Failed to fetch posts');
  }

  Future<List<Comment>> fetchComments(int id) async {
    final uri = Uri.parse('$url$fetchCommentsPath?postId=$id');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      List<Comment> comments = [];
      for (var comment in jsonDecode(response.body)) {
        comments.add(Comment.fromJson(comment));
      }
      return comments;
    }
    throw Exception('Failed to fetch comments');
  }
}
