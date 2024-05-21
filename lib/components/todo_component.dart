import 'package:flutter/material.dart';
import 'package:jsonplaceholder_app/model/todo.dart';

class TodoComponent extends StatefulWidget {
  final Todo todo;

  const TodoComponent({super.key, required this.todo});

  @override
  State<TodoComponent> createState() => _TodoComponentState();
}

class _TodoComponentState extends State<TodoComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: const BoxConstraints(minWidth: double.infinity),
        decoration: BoxDecoration(
            color: Colors.blueAccent.withOpacity(0.2),
            borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            constraints: const BoxConstraints(minWidth: double.infinity),
            child: Row(children: [
              Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100)),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Builder(builder: (context) {
                      if (widget.todo.completed) {
                        return const Icon(Icons.done);
                      }
                      return const Icon(
                        Icons.done,
                        color: Colors.white,
                      );
                    }),
                  )),
              const SizedBox(
                width: 10,
              ),
              Flexible(child: Text(widget.todo.title)),
            ]),
          ),
        ));
  }
}
