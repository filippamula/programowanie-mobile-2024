import 'package:flutter/material.dart';
import 'package:jsonplaceholder_app/components/album_component.dart';
import 'package:jsonplaceholder_app/components/photo_component.dart';
import 'package:jsonplaceholder_app/infrastructure/http_client.dart';
import 'package:jsonplaceholder_app/model/album.dart';
import 'package:jsonplaceholder_app/model/photo.dart';

class SingleAlbumPage extends StatefulWidget {
  final Album album;
  final String author;

  const SingleAlbumPage({super.key, required this.album, required this.author});

  @override
  State<SingleAlbumPage> createState() => _SingleAlbumPageState();
}

class _SingleAlbumPageState extends State<SingleAlbumPage> {
  List<Photo> photos = List.empty();
  var _photosFetched = false;
  final client = HttpClient();

  void setPhotos() async {
    client.fetchPhotos(widget.album.id).then((value) => setState(() {
          photos = value;
          _photosFetched = true;
        }));
  }

  @override
  Widget build(BuildContext context) {
    if (!_photosFetched) {
      setPhotos();
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('${widget.author}\'s album'),
        ),
        body: Column(children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  AlbumComponent(
                    album: widget.album,
                    redirectOnTap: false,
                  ),
                  Column(
                    children: photos
                        .map((e) => PhotoComponent(photo: e))
                        .toList(),
                  )
                ]),
              ),
            ),
          )
        ]));
  }
}
