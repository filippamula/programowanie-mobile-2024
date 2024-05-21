import 'package:flutter/material.dart';
import 'package:jsonplaceholder_app/infrastructure/http_client.dart';
import 'package:jsonplaceholder_app/infrastructure/prefs.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  final titleController = TextEditingController();
  final bodyController = TextEditingController();
  var _isLoading = false;
  final client = HttpClient();
  final prefs = StreamingSharedPreferences.instance;

  Future addPost() async {
    var loggedUserId = await prefs
        .then((prefs) => prefs.getInt(USER_ID, defaultValue: -1).getValue());
    if (loggedUserId == -1) {
      throw Exception('Error during getting logged user id');
    }
    client
        .addPost(titleController.text, bodyController.text, loggedUserId)
        .then((value) => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new post'),
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
            TextField(
              controller: bodyController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                hintText: 'Body',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
                onTap: () {
                  setState(() {
                    _isLoading = true;
                  });
                  addPost().then((value) => setState(() {
                        _isLoading = false;
                      }));
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
