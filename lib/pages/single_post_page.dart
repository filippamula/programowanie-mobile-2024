import 'package:flutter/material.dart';
import 'package:jsonplaceholder_app/components/comment_component.dart';
import 'package:jsonplaceholder_app/components/post_component.dart';
import 'package:jsonplaceholder_app/infrastructure/http_client.dart';
import 'package:jsonplaceholder_app/model/comment.dart';
import 'package:jsonplaceholder_app/model/post.dart';

class SinglePostPage extends StatefulWidget {
  final Post post;
  final String author;

  const SinglePostPage({super.key, required this.post, required this.author});

  @override
  State<SinglePostPage> createState() => _SinglePostPageState();
}

class _SinglePostPageState extends State<SinglePostPage> {
  List<Comment> comments = List.empty();
  var _commentsFetched = false;
  final client = HttpClient();

  void setComments() async {
    client.fetchComments(widget.post.id).then((value) => setState(() {
          comments = value;
          _commentsFetched = true;
        }));
  }

  @override
  Widget build(BuildContext context) {
    if (!_commentsFetched) {
      setComments();
    }
    return Scaffold(
        appBar: AppBar(
          title: Text('${widget.author}\'s post'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              PostComponent(
                post: widget.post,
                redirectOnTap: false,
              ),
              Column(
                children:
                    comments.map((e) => CommentComponent(comment: e)).toList(),
              )
            ]),
          ),
        ));
  }
}
