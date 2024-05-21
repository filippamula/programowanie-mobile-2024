import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jsonplaceholder_app/infrastructure/http_client.dart';
import 'package:jsonplaceholder_app/model/album.dart';
import 'package:jsonplaceholder_app/pages/single_album_page.dart';

class AlbumComponent extends StatefulWidget {
  final Album album;
  final bool redirectOnTap;

  const AlbumComponent(
      {super.key, required this.album, required this.redirectOnTap});

  @override
  State<AlbumComponent> createState() => _AlbumComponentState();
}

class _AlbumComponentState extends State<AlbumComponent> {
  final client = HttpClient();
  var authorName = '';

  void setAuthor() async {
    client
        .fetchUser(widget.album.userId)
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
                  builder: (context) => SingleAlbumPage(
                      album: widget.album, author: authorName)));
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
              Container(
                  constraints: const BoxConstraints(minWidth: double.infinity),
                  child: Text(widget.album.title)),
            ]),
          )),
    );
  }
}
