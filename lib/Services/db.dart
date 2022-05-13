import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:venetian_pines/Models/UserModel.dart';

Future<UserModel> getUser(String uid)async{
 final response=await FirebaseFirestore.instance.collection("Users").doc(uid).get();
 return UserModel.fromJson(response.data());
}