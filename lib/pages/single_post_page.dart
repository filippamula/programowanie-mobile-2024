import 'package:flutter/material.dart';
import 'package:jsonplaceholder_app/components/comment_component.dart';
import 'package:jsonplaceholder_app/components/post_component.dart';
import 'package:jsonplaceholder_app/infrastructure/http_client.dart';
import 'package:jsonplaceholder_app/infrastructure/prefs.dart';
import 'package:jsonplaceholder_app/model/comment.dart';
import 'package:jsonplaceholder_app/model/post.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class SinglePostPage extends StatefulWidget {
  final Post post;
  final String author;

  final TextEditingController commentController = TextEditingController();

  SinglePostPage({super.key, required this.post, required this.author});

  @override
  State<SinglePostPage> createState() => _SinglePostPageState();
}

class _SinglePostPageState extends State<SinglePostPage> {
  List<Comment> comments = List.empty();
  var _commentsFetched = false;
  final client = HttpClient();
  final prefs = StreamingSharedPreferences.instance;

  void setComments() async {
    client.fetchComments(widget.post.id).then((value) => setState(() {
          comments = value;
          _commentsFetched = true;
        }));
  }

  void addComment(String comment) async {
    var loggedUserId = await prefs
        .then((prefs) => prefs.getInt(USER_ID, defaultValue: -1).getValue());
    if (loggedUserId == -1) {
      throw Exception('Error during getting logged user id');
    }

    var loggedUserEmail =
        await client.fetchUser(loggedUserId).then((value) => value.email);
    client
        .addComment(comment, widget.post.id, loggedUserEmail)
        .then((value) => setState(() {
              comments.add(value);
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
        body: Column(children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  PostComponent(
                    post: widget.post,
                    redirectOnTap: false,
                  ),
                  Column(
                    children: comments
                        .map((e) => CommentComponent(comment: e))
                        .toList(),
                  )
                ]),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              child: Container(
                constraints: const BoxConstraints(
                    minWidth: double.infinity, maxHeight: 50),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: widget.commentController,
                          textAlignVertical: TextAlignVertical.bottom,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Comment",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            addComment(widget.commentController.text);
                          },
                          child: const Icon(
                            Icons.send,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ]));
  }
}
