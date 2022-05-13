import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class DocumentModel {
  String docId;
  String title;
  String cover;
  DateTime dateCreated;
  String link;
  bool checked;
  DocumentModel({this.title, this.cover, this.link}) {
    var uuid = Uuid();
    docId = uuid.v1();
    dateCreated = DateTime.now();
  }

  DocumentModel.fromJson(Map<String, dynamic> json) {
    docId = json['docId'];
    title = json['title'];
    cover = json['cover'];
    dateCreated = (json['dateCreated'] as Timestamp).toDate();
    link = json['link'];
    checked = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['docId'] = this.docId;
    data['title'] = this.title;
    data['cover'] = this.cover;
    data['dateCreated'] = this.dateCreated;
    data['link'] = this.link;
    return data;
  }
}
