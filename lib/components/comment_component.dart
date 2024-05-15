import 'package:flutter/material.dart';
import 'package:jsonplaceholder_app/model/comment.dart';

class CommentComponent extends StatefulWidget {
  final Comment comment;

  const CommentComponent({super.key, required this.comment});

  @override
  State<CommentComponent> createState() => _CommentComponentState();
}

class _CommentComponentState extends State<CommentComponent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Container(
          constraints: const BoxConstraints(minWidth: double.infinity),
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(5)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
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
                  Text(widget.comment.email)
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                  constraints: const BoxConstraints(minWidth: double.infinity),
                  child: Text(widget.comment.body))
            ]),
          )),
    );
  }
}
