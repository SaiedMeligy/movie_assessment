import 'dart:io';
import 'package:flutter/foundation.dart' show kDebugMode, kIsWeb;
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'dart:html' as html;


class FullImageScreen extends StatefulWidget {
  final String imageUrl;

  const FullImageScreen({super.key, required this.imageUrl});

  @override
  _FullImageScreenState createState() => _FullImageScreenState();
}

class _FullImageScreenState extends State<FullImageScreen> {

  Future<void> _saveImage() async {
    try {
      var response = await Dio().get(
        widget.imageUrl,
        options: Options(responseType: ResponseType.bytes),
      );



      if (kIsWeb) {
        final blob = html.Blob([response.data]);
        final url = html.Url.createObjectUrlFromBlob(blob);
        final anchor = html.AnchorElement(href: url)
          ..setAttribute('download', 'image.jpg')
          ..click();
        html.Url.revokeObjectUrl(url);
      }
      else {
        final tempDir = await getTemporaryDirectory();
        final file = File('${tempDir.path}/image.jpg');
        await file.writeAsBytes(response.data);

        final bool? result = await ImageGallerySaver.saveFile(file.path);

        if (result == true) {
          if (kDebugMode) {
            print("Image saved successfully!");
          }
        } else {
          if (kDebugMode) {
            print("Failed to save image.");
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error saving image: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Full Image'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save_alt),
            onPressed: _saveImage,
          ),
        ],
      ),
      body: PhotoView(
        imageProvider: NetworkImage(widget.imageUrl),
        minScale: PhotoViewComputedScale.contained,
        maxScale: PhotoViewComputedScale.covered * 2,
      ),
    );
  }
}
