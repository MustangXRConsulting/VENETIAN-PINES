import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:venetian_pines/Providers/UserProvider.dart';
import 'package:venetian_pines/Screens/CreateAccount/CreateAccount.dart';
import 'package:venetian_pines/Screens/MultiNavHome/MultiNavHome.dart';
import 'package:venetian_pines/Screens/resetPasswordScreen.dart';
import 'package:venetian_pines/Services/db.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String id = '', password = '';
  bool emailErr = false;
  bool passErr = false;
  String passMsg = "Please enter password";
  String emailMsg = "Please enter email";

  UserProvider _userProvider;

  bool obscurePass = true;

  void popUntilRoot({Object result}) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
      popUntilRoot();
    }
  }

  showError() {
    setState(() {
      emailErr = id.isEmpty ? true : false;
      passErr = password.isEmpty ? true : false;
    });
  }

  loginUser() async {
    FocusScope.of(context).unfocus();
    print("email = ${hasNoData(id)}");
    if (id.isEmpty || password.isEmpty) {
      showError();
      return;
    }
    // let login
    showLoginDialog(context);
    bool login = await Provider.of<UserProvider>(context, listen: false)
        .loginUser(id, password, context);
    if (login) {
      popUntilRoot();
      if(FirebaseAuth.instance.currentUser.emailVerified){
     final user=await getUser(id);
      await _userProvider.setCurrentUser(user);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MultiNavHome()),
      );
      return;
      }
      else{
        await FirebaseAuth.instance.signOut();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Verify your email to Login"))
        );
        return ;
      }
    }
  }

  bool hasNoData(String field) {
    return field == null && field.isEmpty;
  }

  showLoginDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text("Logging in to Venetian Pines"),
      content: Padding(
        padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
        child: Row(
          children: [
            CircularProgressIndicator(
                valueColor:
                    new AlwaysStoppedAnimation<Color>(Color(0xff01702E))),
            SizedBox(
              width: 10,
            ),
            Text("Please wait...")
          ],
        ),
      ),
    );
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
    void initState() {
      _userProvider=Provider.of<UserProvider>(context,listen: false);
      super.initState();
    }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    OutlineInputBorder focusBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      borderSide: BorderSide(width: 1, color: Colors.black),
    );
    OutlineInputBorder errBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      borderSide: BorderSide(width: 1, color: Colors.red),
    );
    Color hintColor = Color(0xff747474);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: w,
          height: h,
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
                width: double.infinity,
                height: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 61,
                      ),
                      Center(
                          child: SvgPicture.asset(
                        'assets/bottom_nav/logo.svg',
                        width: w * .4,
                        height: w * .4,
                        semanticsLabel: 'Close',
                      )),
                      SizedBox(
                        height: 60,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Text(
                          'Welcome Back!',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff01443A)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0, top: 10),
                        child: Text(
                          'Log in to Venetian Pines using your\nemail and password.',
                          style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(66, 72, 71, 1)),
                        ),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Row(
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
                      ),
                      Container(
                        height: 60,
                        margin: EdgeInsets.only(left: 18, right: 18, top: 5),
                        child: Theme(
                          data: ThemeData(
                              hintColor: emailErr ? Colors.red : Colors.black),
                          child: TextField(
                            onChanged: (val) {
                              id = val;
                              if (val.length > 0) {
                                setState(() {
                                  emailErr = false;
                                });
                              }
                            },
                            decoration: InputDecoration(
                                focusedBorder:
                                    emailErr ? errBorder : focusBorder,
                                border: emailErr
                                    ? errBorder
                                    : OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                filled: true,
                                hintStyle: TextStyle(
                                    color: hintColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 19),
                                hintText: 'Enter your email',
                                fillColor: Colors.white),
                          ),
                        ),
                      ),
                      if (emailErr) errorMsg(emailMsg),
                      SizedBox(
                        height: 17,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Row(
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
                              'Password',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 60,
                        margin: EdgeInsets.only(left: 18, right: 18, top: 5),
                        child: Theme(
                          data: ThemeData(
                              hintColor: passErr ? Colors.red : Colors.black),
                          child: TextField(
                            onChanged: (val) {
                              password = val;
                              if (val.length > 0) {
                                setState(() {
                                  passErr = false;
                                });
                              }
                            },
                            obscureText: obscurePass,
                            decoration: InputDecoration(
                                focusedBorder:
                                    passErr ? errBorder : focusBorder,
                                border: passErr
                                    ? errBorder
                                    : OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                filled: true,
                                suffixIcon: IconButton(
                                  icon: Icon(!obscurePass
                                      ? Icons.remove_red_eye
                                      : Icons.visibility_off,color: hintColor,),
                                  onPressed: () => setState(
                                      () => obscurePass = !obscurePass),
                                ),
                                hintStyle: TextStyle(
                                    color: hintColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 19),
                                hintText: 'Enter password',
                                fillColor: Colors.white),
                          ),
                        ),
                      ),
                      if (passErr) errorMsg(passMsg),
                      SizedBox(
                        height: 40,
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            loginUser();
                          },
                          child: Container(
                            height: h * 0.08,
                            width: w * 0.89,
                            decoration: BoxDecoration(
                              color: Color(0xff01443A),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Center(
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don’t have an account? ',
                            style: TextStyle(
                                color: Color(0xff5F5F5F), fontSize: 16),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (_) => CreateAccount()),
                              );
                            },
                            child: Text(
                              'Create account',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Forgot Password? ',
                            style: TextStyle(
                                color: Color(0xff5F5F5F), fontSize: 16),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (_) => ResetPasswordScreen()),
                              );
                            },
                            child: Text(
                              'Reset',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
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

Widget errorMsg(String error) {
    return Container(
      height: 35,
      margin: EdgeInsets.only(top: 8, right: 18, left: 18),
      decoration: BoxDecoration(
        color: Color(0xffB50606).withOpacity(.1),
        borderRadius: BorderRadius.all(Radius.circular(3.75)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 8,
          ),
          SvgPicture.asset(
            'assets/bottom_nav/error.svg',
            width: 17,
            height: 15,
            semanticsLabel: 'A red up arrow',
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            error,
            style: TextStyle(fontSize: 17),
          )
        ],
      ),
    );
  }
