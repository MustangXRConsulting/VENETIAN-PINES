import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class MaintenanceModel {
  String issueId;
  String name;
  String address;
  DateTime dateCreated;
  String issue, email;
  String status;
  DateTime lastUpdated;
  bool checked;
  String category;
  MaintenanceModel(
      {this.name,
      this.address,
      this.issue,
      this.dateCreated,
      this.email,
      this.category}) {
    status = '0';
    lastUpdated = dateCreated;
    var uuid = Uuid();
    issueId = uuid.v1();
  }

  MaintenanceModel.fromJson(Map<String, dynamic> json) {
    issueId = json['issueId'];
    name = json['name'];
    email = json['email'];
    address = json['address'];
    category = json['category'];
    dateCreated = (json['dateCreated'] as Timestamp).toDate();
    issue = json['issue'];
    status = json['status'];
    lastUpdated = (json['lastUpdated'] as Timestamp).toDate();
    checked = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['issueId'] = this.issueId;
    data['name'] = this.name;
    data['address'] = this.address;
    data['dateCreated'] = this.dateCreated;
    data['issue'] = this.issue;
    data['category'] = this.category;
    data['status'] = this.status;
    data['email'] = this.email;
    data['lastUpdated'] = this.lastUpdated;
    return data;
  }
}
