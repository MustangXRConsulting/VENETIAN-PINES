import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String pid;
  String title;
  String description;
  String url;
  String image;
  bool active;
  DateTime createdOn;
  String type;
  String time;
  String topic;
  Uint8List memoryImage;

  PostModel.fromJson(Map<String, dynamic> json) {
    pid = json['pid'];
    title = json['title'];
    topic=json["topic"];
    description = json['description'];
    url = json['url'];
    image = json['image'];
    active = json['active'];
    createdOn = (json['createdOn'] as Timestamp).toDate();
    time=json['eventTime']??"12:00 PM";
    type = json['type'];
  }
}
