import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:venetian_pines/Models/UserModel.dart';
import 'package:venetian_pines/Services/Authentication.dart';
import 'package:venetian_pines/Services/db.dart';

class UserProvider extends ChangeNotifier {
  String uid;
  AuthenticationService auth = new AuthenticationService();

  UserModel currentUser;

  fetchLocal() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    uid = sharedPref.getString('user');
    currentUser = await getUser(uid);
    notifyListeners();
  }

  signupUser(UserModel um, BuildContext context) async {
    return await auth.handleSignUp(context, um);
  }

  loginUser(String email, String password, BuildContext context) async {
    return await auth.handleLogin(
        context: context, email: email, password: password);
  }

  welcomedUser() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.setString('welcomed', 'yes');
  }

  setCurrentUser(UserModel user) async{
    currentUser = user;
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
        sharedPref.setString("user", user.email);
    notifyListeners();
  }

  updateInfo(
      {@required String name,
      @required String address,
      @required String phone}) {
    currentUser.name = name;
    currentUser.address = address;
    currentUser.phone = phone;
    notifyListeners();
  }

  updateEmail({@required String email}) async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser.email)
        .delete();
    currentUser.email = email;
    FirebaseFirestore.instance
        .collection("Users")
        .doc(email)
        .set(currentUser.toJson());
    notifyListeners();
  }
}
