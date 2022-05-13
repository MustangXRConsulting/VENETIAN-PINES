import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String name, address, phone, email, password;
  DateTime joinedOn;
  bool blocked;
  UserModel(
      {this.name,
      this.password,
      this.address,
      this.email,
      this.joinedOn,
      this.phone}) {
    joinedOn = DateTime.now();
    blocked = false;
  }

  UserModel.fromJson(Map<String, dynamic> data) {
    this.name = data['name']??"Name";
    this.address = data['address'];
    this.phone = data['phone'];
    this.email = data['email'];
    this.blocked = data['block'];
    this.joinedOn = (data['joinedOn'] as Timestamp).toDate();
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map();
    data['name'] = this.name;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['joinedOn'] = this.joinedOn;
    data['block'] = this.blocked;
    return data;
  }
}
