import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:venetian_pines/Providers/UserProvider.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool passwrod_visible1 = true;
  bool passwrod_visible2 = true;

  bool isUpdating = false;

  Color hintColor = Color(0xff747474);

  OutlineInputBorder focusBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
    borderSide: BorderSide(width: 1, color: Colors.black),
  );

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  UserProvider userProvider;

  initState() {
    userProvider = Provider.of<UserProvider>(context, listen: false);
    super.initState();
  }

  onChange() async {
    try {
      if (oldPasswordController.text.trim().length < 6 ||
          newPasswordController.text.trim().length < 6)
        return Toast.show(
            "Both passwords length must be atleast 6 characters", context);

      setState(() => isUpdating = true);
      await FirebaseAuth.instance.currentUser.reauthenticateWithCredential(
          EmailAuthProvider.credential(
              email: userProvider.currentUser.email,
              password: oldPasswordController.text.trim()));

    await  FirebaseAuth.instance.currentUser
          .updatePassword(newPasswordController.text.trim());

    Toast.show("Password Changed", context);
    }
    on FirebaseAuthException catch(e){
     Toast.show(e.message??"Something went wrong", context);
    }
     catch (e) {
      Toast.show("Something went wrong", context);
    } finally {
      setState(() => isUpdating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;

    var h = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      child: Stack(
        children: [
          Image.asset(
            'assets/back.png',
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          Image.asset('assets/grad2.png',
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.fill),
          Container(
            height: double.infinity,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 60,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_back_ios_outlined,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Back',
                        style: TextStyle(color: Colors.white, fontSize: 19),
                      )
                    ],
                  ),
                ),
                Center(
                    child: SvgPicture.asset(
                  'assets/bottom_nav/logo.svg',
                  width: w * .4,
                  height: w * .4,
                  semanticsLabel: 'Close',
                )),
                SizedBox(
                  height: 40,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Change Password",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff01443A)),
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/bottom_nav/lock.svg',
                              semanticsLabel: 'password',
                              width: 20,
                              height: 20,
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Text(
                              'Old Password*',
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                        Container(
                          height: 60,
                          margin: EdgeInsets.only(top: 5),
                          child: Theme(
                            data: ThemeData(hintColor: Colors.black),
                            child: TextField(
                              obscureText: passwrod_visible1,
                              controller: oldPasswordController,
                              decoration: InputDecoration(
                                  focusedBorder: focusBorder,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  filled: true,
                                  suffixIcon: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          passwrod_visible1 =
                                              !passwrod_visible1;
                                        });
                                      },
                                      child: Icon(
                                        passwrod_visible1
                                            ? Icons.visibility_off
                                            : Icons.visibility_sharp,
                                        color: Colors.black,
                                      )),
                                  hintStyle: TextStyle(
                                      color: hintColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 19),
                                  hintText: "Enter old password",
                                  fillColor: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/bottom_nav/lock.svg',
                              semanticsLabel: 'password',
                              width: 20,
                              height: 20,
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Text(
                              'New Password*',
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                        Container(
                          height: 60,
                          margin: EdgeInsets.only(top: 5),
                          child: Theme(
                            data: ThemeData(hintColor: Colors.black),
                            child: TextField(
                              obscureText: passwrod_visible2,
                              controller: newPasswordController,
                              decoration: InputDecoration(
                                  focusedBorder: focusBorder,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  filled: true,
                                  suffixIcon: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          passwrod_visible2 =
                                              !passwrod_visible2;
                                        });
                                      },
                                      child: Icon(
                                        passwrod_visible2
                                            ? Icons.visibility_off
                                            : Icons.visibility_sharp,
                                        color: Colors.black,
                                      )),
                                  hintStyle: TextStyle(
                                      color: hintColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 19),
                                  hintText: "Enter new password",
                                  fillColor: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: onChange,
                            child: Container(
                              height: h * 0.08,
                              width: w * 0.89,
                              decoration: BoxDecoration(
                                color: Color(0xff01443A),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Center(
                                child: isUpdating
                                    ? CircularProgressIndicator()
                                    : Text(
                                        'Change Password',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600),
                                      ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}
