import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import 'ColorConstants.dart';

class FullPhotoPage extends StatelessWidget {
  final String url;

  FullPhotoPage({this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '',
          style: TextStyle(
              color: ColorConstants.primaryColor, fontWeight: FontWeight.bold,fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: PhotoView(
          imageProvider: NetworkImage(url),
        ),
      ),
    );
  }
}
