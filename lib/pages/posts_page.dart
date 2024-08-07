import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jsonplaceholder_app/components/post_component.dart';
import 'package:jsonplaceholder_app/infrastructure/http_client.dart';
import 'package:jsonplaceholder_app/pages/add_post_page.dart';

import '../model/post.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  List<Post> posts = List.empty();
  var _postsFetched = false;
  final client = HttpClient();

  void setPosts() async {
    client.fetchPosts().then((value) => setState(() {
          posts = value;
          _postsFetched = true;
        }));
  }

  @override
  Widget build(BuildContext context) {
    if (!_postsFetched) {
      setPosts();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => const AddPostPage()));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: posts
              .map((e) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PostComponent(post: e),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
