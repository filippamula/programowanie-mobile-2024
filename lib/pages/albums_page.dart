import 'package:flutter/material.dart';
import 'package:jsonplaceholder_app/components/album_component.dart';
import 'package:jsonplaceholder_app/infrastructure/http_client.dart';
import 'package:jsonplaceholder_app/model/album.dart';

class AlbumsPage extends StatefulWidget {
  const AlbumsPage({super.key});

  @override
  State<AlbumsPage> createState() => _AlbumsPageState();
}

class _AlbumsPageState extends State<AlbumsPage> {
  List<Album> albums = List.empty();
  var _albumsFetched = false;
  final client = HttpClient();

  void setAlbums() async {
    client.fetchAlbums().then((value) => setState(() {
          albums = value;
          _albumsFetched = true;
        }));
  }

  @override
  Widget build(BuildContext context) {
    if (!_albumsFetched) {
      setAlbums();
    }
    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
        children: albums
            .map((e) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AlbumComponent(
                    album: e,
                    redirectOnTap: true,
                  ),
                ))
            .toList(),
      ),
    ));
  }
}
