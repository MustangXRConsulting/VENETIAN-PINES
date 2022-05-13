import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toast/toast.dart';
import 'package:venetian_pines/Screens/resetPassSuccessfulScreen.dart';

import '../main.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  OutlineInputBorder focusBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
    borderSide: BorderSide(width: 1, color: Colors.black),
  );
  OutlineInputBorder errBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
    borderSide: BorderSide(width: 1, color: Colors.red),
  );

  TextEditingController _emailController = TextEditingController();

  initState() {
    _emailController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: devHeight,
          width: devWidth,
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
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 61,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: TextButton.icon(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: 20,
                            ),
                            label: Text(
                              "Back",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            )),
                      ),
                      Center(
                          child: SvgPicture.asset(
                        'assets/bottom_nav/logo.svg',
                        width: devWidth * .4,
                        height: devWidth * .4,
                        semanticsLabel: 'Close',
                      )),
                      SizedBox(
                        height: 60,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0, top: 10,right: 18),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Reset Password',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff01443A)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Need a new password? Please enter your email below to continue. We’ll email you a link to make a new one.',
                              style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(66, 72, 71, 1)),
                            ),
                            SizedBox(
                              height: 32,
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/bottom_nav/email.svg',
                                  semanticsLabel: 'Email',
                                  width: 15,
                                  height: 15,
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                Text('Email',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16))
                              ],
                            ),
                            Container(
                              height: 60,
                              margin: EdgeInsets.only( top: 5),
                              child: Theme(
                                data: ThemeData(hintColor: Colors.black),
                                child: TextField(
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                      focusedBorder: focusBorder,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      filled: true,
                                      hintStyle: TextStyle(
                                          color: Color(0xff747474),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 19),
                                      hintText: 'Enter your email',
                                      fillColor: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            GestureDetector(
                              onTap: _emailController.text.length > 0
                                  ? () async {
                                      try {
                                        if (!isEmailValid(
                                            _emailController.text))
                                          return Toast.show(
                                              "Invalid email", context);

                                        await FirebaseAuth.instance
                                            .sendPasswordResetEmail(
                                                email: _emailController.text);
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    ResetPassSuccessfulScreen()));
                                      } on FirebaseAuthException catch (e) {
                                        return Toast.show(e.message, context,
                                            duration: 5);
                                      } catch (e) {
                                        return Toast.show(
                                            "Something went wrong", context);
                                      }
                                    }
                                  : null,
                              child: Container(
                                height: devHeight * 0.08,
                                width: devWidth,
                                decoration: BoxDecoration(
                                  color: _emailController.text.length > 0
                                      ? Color(0xff01443A)
                                      : Color(0XFFD3D3D3),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Center(
                                  child: Text(
                                    'Submit',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 32,
                            ),
                            GestureDetector(
                              onTap: () => Navigator.of(context).pop(),
                              child: Center(
                                child: Text(
                                  'Back to Sign in',
                                  style: TextStyle(
                                      color: Color(0xff5F5F5F), fontSize: 16),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

bool isEmailValid(String email) => RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
    .hasMatch(email);
