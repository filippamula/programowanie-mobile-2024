import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:jsonplaceholder_app/model/album.dart';
import 'package:jsonplaceholder_app/model/comment.dart';
import 'package:jsonplaceholder_app/model/photo.dart';
import 'package:jsonplaceholder_app/model/post.dart';
import 'package:jsonplaceholder_app/model/todo.dart';

import '../model/user.dart';

class HttpClient {
  static const String url = 'https://jsonplaceholder.typicode.com';
  static const String usersPath = '/users';
  static const String postsPath = '/posts';
  static const String commentsPath = '/comments';
  static const String albumsPath = '/albums';
  static const String photosPath = '/photos';
  static const String todosPath = '/todos';

  Future<List<User>> fetchUsers() async {
    final uri = Uri.parse(url + usersPath);
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

  Future<User> fetchUser(int id) async {
    final uri = Uri.parse("$url$usersPath/$id");
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    }
    throw Exception('Failed to fetch user');
  }

  Future<List<Post>> fetchPosts() async {
    final uri = Uri.parse(url + postsPath);
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
    final uri = Uri.parse('$url$commentsPath?postId=$id');
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

  Future<Comment> addComment(String comment, int postId, String email) async {
    final uri = Uri.parse(url + commentsPath);
    final response = await http.post(uri,
        headers: <String, String>{
          'ContentType': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "postId": postId,
          "body": comment,
          "email": email
        }));

    if (response.statusCode == 201) {
      return Comment(
        postId: postId,
        id: jsonDecode(response.body)['id'],
        name: '',
        email: email,
        body: comment,
      );
    }
    throw Exception('Failed to fetch comments');
  }

  Future<List<Album>> fetchAlbums() async {
    final uri = Uri.parse(url + albumsPath);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      List<Album> albums = [];
      for (var album in jsonDecode(response.body)) {
        albums.add(Album.fromJson(album));
      }
      return albums;
    }
    throw Exception('Failed to fetch albums');
  }

  Future<List<Photo>> fetchPhotos(int id) async {
    final uri = Uri.parse('$url$photosPath?albumId=$id');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      List<Photo> photos = [];
      for (var photo in jsonDecode(response.body)) {
        photos.add(Photo.fromJson(photo));
      }
      return photos;
    }
    throw Exception('Failed to fetch photos');
  }

  Future<Post> addPost(String title, String body, int userId) async {
    final uri = Uri.parse(url + postsPath);
    final response = await http.post(uri,
        body: jsonEncode(
            <String, dynamic>{"userId": userId, "title": title, "body": body}));

    if (response.statusCode == 201) {
      return Post(
          userId: userId,
          id: jsonDecode(response.body)['id'],
          title: title,
          body: body);
    }
    throw Exception('Failed to add post');
  }

  Future<Album> addAlbum(int userId, String title, List<File> files) async {
    final uri = Uri.parse(url + albumsPath);
    final response = await http.post(uri,
        body: jsonEncode(<String, dynamic>{"userId": userId, "title": title}));

    if (response.statusCode == 201) {
      return Album(
          userId: userId, id: jsonDecode(response.body)['id'], title: title);
    }
    throw Exception('Failed to add post');
  }

  Future<List<Todo>> fetchTodos() async {
    final uri = Uri.parse(url + todosPath);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      List<Todo> todos = [];
      for (var todo in jsonDecode(response.body)) {
        todos.add(Todo.fromJson(todo));
      }
      return todos;
    }
    throw Exception('Failed to fetch todos');
  }
}
