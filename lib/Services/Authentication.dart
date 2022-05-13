import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:venetian_pines/Models/UserModel.dart';

class AuthenticationService {
  //Signup the user
  Future<bool> handleSignUp(BuildContext context, UserModel um) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: um.email, password: um.password);

      await FirebaseFirestore.instance
          .collection("Users")
          .doc(um.email)
          .set(um.toJson());
      return true;
    } catch (e) {
      Navigator.of(context, rootNavigator: true).pop();
      print("error occured ${e.code}");
      if (e.code == 'weak-password') {
        await errorDialog(context, "Weak password isn't allowed");
      } else if (e.code == 'email-already-in-use') {
        await errorDialog(context, "Account already exist please login");
      } else {
        await errorDialog(context, "Failed to create account");
      }
      return false;
    }
  }

  // login the user
  Future<bool> handleLogin(
      {BuildContext context, String email, String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection("Users")
          .where("email", isEqualTo: email)
          .get();
      return true;
    } catch (e) {
      print("error occured ${e.code}");
      Navigator.of(context, rootNavigator: true).pop();
      if (e.code == 'user-not-found') {
        await errorDialog(context, "This $email isn't  registered.");
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        await errorDialog(context, "Incorrect password.");
      } else if (e.code == "invalid-email") {
        await errorDialog(context, "You've entered invalid email ");
      } else {
        await errorDialog(context, "Failed to login check your credentials.");
      }
      return false;
    }
  }

  // getting user
  Future<Map<String, dynamic>> getUser() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    Map<String, dynamic> user = jsonDecode(sharedPref.getString("user"));
    return user;
  }

  // error dialogue
  errorDialog(BuildContext context, String msg) {
    Toast.show(msg, context,
        duration: Toast.LENGTH_LONG,
        backgroundColor: Color(0xff01702E),
        textColor: Colors.white);
  }
}
