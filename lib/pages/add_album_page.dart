import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jsonplaceholder_app/infrastructure/http_client.dart';
import 'package:jsonplaceholder_app/infrastructure/prefs.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class AddAlbumPage extends StatefulWidget {
  const AddAlbumPage({super.key});

  @override
  State<AddAlbumPage> createState() => _AddAlbumPageState();
}

class _AddAlbumPageState extends State<AddAlbumPage> {
  var _isLoading = false;
  final titleController = TextEditingController();
  List<XFile> files = List.empty(growable: true);
  final client = HttpClient();
  final imagePicker = ImagePicker();
  var prefs = StreamingSharedPreferences.instance;

  Future addAlbum() async {
    setState(() {
      _isLoading = true;
    });
    var loggedUserId = await prefs
        .then((prefs) => prefs.getInt(USER_ID, defaultValue: -1).getValue());
    if (loggedUserId == -1) {
      throw Exception('Error during getting logged user id');
    }

    await client.addAlbum(loggedUserId, titleController.text,
        files.map((e) => File(e.path)).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add new album'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const TextField(
                  decoration: InputDecoration(hintText: 'Title'),
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: files
                      .map((e) => Stack(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Image.file(File(e.path))),
                              Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(100)),
                                  child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          files.remove(e);
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.close,
                                        size: 32,
                                        color: Colors.indigoAccent,
                                      )),
                                ),
                              )
                            ],
                          ))
                      .toList(),
                ),
                IconButton(
                    onPressed: () {
                      imagePicker.pickMultiImage().then((value) => setState(() {
                            files.addAll(value);
                          }));
                    },
                    icon: const Icon(Icons.add)),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                    onTap: addAlbum,
                    child: SafeArea(
                      child: GestureDetector(
                        onTap: () {
                          addAlbum().then((value) => Navigator.pop(context));
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
                                      ))),
                      ),
                    ))
              ],
            ),
          ),
        ));
  }
}
