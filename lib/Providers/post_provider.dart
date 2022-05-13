import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:venetian_pines/Models/PostModel.dart';
import 'package:venetian_pines/Services/post_service.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class PostProivder extends ChangeNotifier {
  PostService postService = new PostService();
  List<PostModel> posts = [];
  List<PostModel> orgPosts = [];
  String type;
  // set type
  void setType(String type) {
    this.type = type;
  }

  // get all bulletins
  Future<List<PostModel>> getAllPosts(bool resize) async {
    print('getting all posts for type = $type');
    posts = [];
    orgPosts = [];
    posts = await postService.getAllPosts(type);
    posts
        .sort((PostModel a, PostModel b) => a.createdOn.compareTo(b.createdOn));
    orgPosts = posts;
    if (resize)
      await resizeAll();
    else
      await resizeAll1();
    notifyListeners();
  }

  // filter by query
  void filterByQuery(String query) {
    List<PostModel> cts = [];
    for (int i = 0; i < orgPosts.length; i++) {
      if (orgPosts[i].title.toLowerCase().contains(query.toLowerCase())) {
        cts.add(orgPosts[i]);
      }
    }
    posts = cts;
    notifyListeners();
  }

  // filter by month
  void filterByMonth(int month) {
    List<PostModel> cts = [];
    for (int i = 0; i < orgPosts.length; i++) {
      if (orgPosts[i].createdOn.month == month) {
        cts.add(orgPosts[i]);
      }
    }
    posts = cts;
    notifyListeners();
  }

  // filter by year
  void filterByYear(int year) {
    List<PostModel> cts = [];
    for (int i = 0; i < orgPosts.length; i++) {
      if (orgPosts[i].createdOn.year == year) {
        cts.add(orgPosts[i]);
      }
    }
    posts = cts;
    notifyListeners();
  }

  void filterByTopic(String topic) {
    List<PostModel> cts = [];
    for (int i = 0; i < orgPosts.length; i++) {
      if (orgPosts[i].topic != null && orgPosts[i].topic == topic) {
        cts.add(orgPosts[i]);
      }
    }
    posts = cts;
    notifyListeners();
  }

  // resize all images
  Future<void> resizeAll() async {
    for (int i = 0; i < posts.length; i++) {
      posts[i].memoryImage = await resizeImage(posts[i].image, w: 125, h: 150);
    }
  }

  // resize all images1
  Future<void> resizeAll1() async {
    for (int i = 0; i < posts.length; i++) {
      posts[i].memoryImage = await resizeImage(posts[i].image);
    }
  }

  // resize image
  Future<Uint8List> _resizeImage(String imageUrl) async {
    Uint8List targetlUinit8List;
    Uint8List originalUnit8List;
    http.Response response = await http.get(Uri.parse(imageUrl));
    originalUnit8List = response.bodyBytes;

    ui.Image originalUiImage = await decodeImageFromList(originalUnit8List);
    ByteData originalByteData = await originalUiImage.toByteData();
    print('original image ByteData size is ${originalByteData.lengthInBytes}');

    var codec = await ui.instantiateImageCodec(originalUnit8List,
        targetHeight: 180, targetWidth: 125);
    var frameInfo = await codec.getNextFrame();
    ui.Image targetUiImage = frameInfo.image;

    ByteData targetByteData =
        await targetUiImage.toByteData(format: ui.ImageByteFormat.png);
    print('target image ByteData size is ${targetByteData.lengthInBytes}');
    targetlUinit8List = targetByteData.buffer.asUint8List();
    return targetlUinit8List;
  }

  Future<Uint8List> resizeImage(String img, {double w, double h}) async {
    http.Response response = await http.get(Uri.parse(img));
    Uint8List list = response.bodyBytes;
    var result = await FlutterImageCompress.compressWithList(
      list,
      minHeight: w != null ? w.toInt() : 150,
      minWidth: h != null ? h.toInt() : 315,
      quality: 96,
      rotate: 0,
    );
    return result;
  }
}
