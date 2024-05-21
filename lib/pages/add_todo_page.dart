import 'package:flutter/material.dart';
import 'package:jsonplaceholder_app/infrastructure/http_client.dart';
import 'package:jsonplaceholder_app/infrastructure/prefs.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final titleController = TextEditingController();
  final bodyController = TextEditingController();
  var _isLoading = false;
  final client = HttpClient();
  final prefs = StreamingSharedPreferences.instance;

  Future addTodo() async {
    setState(() {
      _isLoading = true;
    });
    var loggedUserId = await prefs
        .then((prefs) => prefs.getInt(USER_ID, defaultValue: -1).getValue());
    if (loggedUserId == -1) {
      throw Exception('Error during getting logged user id');
    }
    await client.addTodo(loggedUserId, titleController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(hintText: 'Title'),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
                onTap: () {
                  addTodo().then((value) => Navigator.pop(context));
                },
                child: Container(
                    height: 70,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: Colors.indigoAccent,
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                        child: _isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                'Add',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ))))
          ],
        ),
      ),
    );
  }
}
