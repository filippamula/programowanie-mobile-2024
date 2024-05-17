import 'package:flutter/material.dart';
import 'package:jsonplaceholder_app/model/photo.dart';

class PhotoComponent extends StatefulWidget {
  final Photo photo;

  const PhotoComponent({super.key, required this.photo});

  @override
  State<PhotoComponent> createState() => _PhotoComponentState();
}

class _PhotoComponentState extends State<PhotoComponent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.network(widget.photo.url),
    );
  }
}
