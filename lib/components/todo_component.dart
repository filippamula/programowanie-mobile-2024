import 'package:flutter/material.dart';
import 'package:jsonplaceholder_app/infrastructure/http_client.dart';
import 'package:jsonplaceholder_app/model/todo.dart';

class TodoComponent extends StatefulWidget {
  final Todo todo;

  const TodoComponent({super.key, required this.todo});

  @override
  State<TodoComponent> createState() => _TodoComponentState();
}

class _TodoComponentState extends State<TodoComponent> {
  final client = HttpClient();
  var _isLoading = false;
  bool? _completed;

  void setTodoCompleted(bool completed) async {
    setState(() {
      _isLoading = true;
    });
    final todoChanged = await client.editTodo(widget.todo, completed);
    setState(() {
      _completed = todoChanged.completed;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    _completed ??= widget.todo.completed;
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
                  child: Builder(builder: (context) {
                    if (_isLoading) {
                      return const SizedBox(
                        height: 45,
                        width: 45,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(
                            color: Colors.indigoAccent,
                          ),
                        ),
                      );
                    }
                    if (_completed ??= false) {
                      return SizedBox(
                        height: 45,
                        width: 45,
                        child: IconButton(
                          icon: const Icon(Icons.done),
                          onPressed: () {
                            setTodoCompleted(false);
                          },
                        ),
                      );
                    }
                    return SizedBox(
                      height: 45,
                      width: 45,
                      child: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          setTodoCompleted(true);
                        },
                      ),
                    );
                  })),
              const SizedBox(
                width: 10,
              ),
              Flexible(child: Text(widget.todo.title)),
            ]),
          ),
        ));
  }
}
