import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../infrastructure/http_client.dart';
import '../model/post.dart';
import '../pages/single_post_page.dart';

class PostComponent extends StatefulWidget {
  final Post post;
  final bool redirectOnTap;

  const PostComponent(
      {super.key, required this.post, this.redirectOnTap = true});

  @override
  State<PostComponent> createState() => _PostComponentState();
}

class _PostComponentState extends State<PostComponent> {
  final client = HttpClient();
  var authorName = '';

  void setAuthor() async {
    client
        .fetchUser(widget.post.userId)
        .then((value) => setState(() {
              authorName = value.name;
            }));
  }

  @override
  Widget build(BuildContext context) {
    if (authorName == '') {
      setAuthor();
    }

    return GestureDetector(
      onTap: () {
        if (widget.redirectOnTap) {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) =>
                      SinglePostPage(post: widget.post, author: authorName)));
        }
      },
      child: Container(
          constraints: const BoxConstraints(minWidth: double.infinity),
          decoration: BoxDecoration(
              color: Colors.blueAccent.withOpacity(0.2),
              borderRadius: BorderRadius.circular(5)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(100)),
                    child: const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Icon(
                        Icons.person,
                        size: 25,
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Text(authorName)
                ],
              ),
              const SizedBox(height: 5),
              Column(
                children: [
                  Container(
                      constraints:
                          const BoxConstraints(minWidth: double.infinity),
                      child: Text(widget.post.title)),
                  const SizedBox(height: 10),
                  Container(
                    constraints:
                        const BoxConstraints(minWidth: double.infinity),
                    child: Text(widget.post.body),
                  )
                ],
              )
            ]),
          )),
    );
  }
}
