import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentModel {
  String payId;
  String title;
  String email;
  String cardEnding;
  DateTime dateTime;
  String amount;

  PaymentModel({this.payId, this.title, this.email, this.dateTime});

  PaymentModel.fromJson(Map<String, dynamic> json) {
    payId = json['payId'];
    title = json['title'];
    email = json['email'];
    amount = json['amount'];
    cardEnding = json['cardEnding'];
    dateTime = (json['dateTime'] as Timestamp).toDate();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payId'] = this.payId;
    data['title'] = this.title;
    data['email'] = this.email;
    data['amount'] = this.amount;
    data['cardEnding'] = this.cardEnding;
    data['dateTime'] = this.dateTime;
    return data;
  }
}
