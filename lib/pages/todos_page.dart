import 'package:flutter/material.dart';
import 'package:jsonplaceholder_app/components/todo_component.dart';
import 'package:jsonplaceholder_app/infrastructure/http_client.dart';
import 'package:jsonplaceholder_app/model/todo.dart';

class TodosPage extends StatefulWidget {
  const TodosPage({super.key});

  @override
  State<TodosPage> createState() => _TodosPageState();
}

class _TodosPageState extends State<TodosPage> {
  List<Todo> todos = List.empty();
  var _todosFetched = false;
  final client = HttpClient();

  void fetchTodos() {
    client.fetchTodos().then((value) => setState(() {
          todos = value;
          _todosFetched = true;
        }));
  }

  @override
  Widget build(BuildContext context) {
    if (!_todosFetched) {
      fetchTodos();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos'),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.add))],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: todos
              .map((e) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TodoComponent(todo: e),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
