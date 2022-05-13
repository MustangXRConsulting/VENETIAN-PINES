import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:venetian_pines/Models/UserModel.dart';
import 'package:venetian_pines/Providers/UserProvider.dart';
import 'package:venetian_pines/Screens/CommunityDocuments/OpenDoc.dart';
import 'package:venetian_pines/Screens/Login/LoginPage.dart';
import 'package:venetian_pines/Screens/MultiNavHome/MultiNavHome.dart';
import 'package:venetian_pines/Screens/webViewScreen.dart';
import 'package:venetian_pines/Services/db.dart';

import '../../constant.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  String name = '',
      address = '',
      phone = '',
      email = '',
      password = '',
      confirmPass = '';
  bool submit = false;
  TextEditingController pass = new TextEditingController();
  TextEditingController confirm = new TextEditingController();
  bool terms = false;
  bool passwrod_visible = true;
  bool passwrod_visible1 = true;
  bool nameErr = false;
  bool addressErr = false;
  bool phoneErr = false;
  bool emailErr = false;
  bool passErr = false;
  bool cpErr = false;
  bool passEqualErr = false;

  UserProvider _userProvider;

  void popUntilRoot({Object result}) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
      popUntilRoot();
    }
  }

  showError() {
    setState(() {
      nameErr = name.isEmpty ? true : false;
      addressErr = address.isEmpty ? true : false;
      phoneErr = phone.isEmpty ? true : false;
      emailErr = email.isEmpty ? true : false;
      passErr = password.isEmpty ? true : false;
      cpErr = confirmPass.isEmpty ? true : false;
    });
    print('name error : $nameErr');
  }

  signupUser() async {
    FocusScope.of(context).unfocus();
    if (password != confirmPass) {
      pass.clear();
      confirm.clear();
      setState(() {
        passEqualErr = true;
      });
      return;
    }
    // let signup
    if (hasNoData(name) ||
        hasNoData(address) ||
        hasNoData(phone) ||
        hasNoData(email) ||
        hasNoData(password) ||
        hasNoData(confirmPass) ||
        !terms) {
      showError();
      return;
    }
    showSignupDialog(context);
    UserModel um = new UserModel(
        name: name,
        address: address,
        email: email,
        password: password,
        phone: phone);
    bool singup = await Provider.of<UserProvider>(context, listen: false)
        .signupUser(um, context);
    if (singup) {
      Navigator.of(context,rootNavigator: true).pop();
      await FirebaseAuth.instance.currentUser.sendEmailVerification();
      await FirebaseAuth.instance.signOut();
      successfullyCreatedAccountDialog(context);
      // popUntilRoot();
      // final user = await getUser(email);
      // _userProvider.setCurrentUser(user);
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => MultiNavHome()),
      // );
      return;
    }
  }

  bool hasNoData(String field) {
    return field != null && field.isEmpty;
  }

  showSignupDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text("Creating your account"),
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

  successfullyCreatedAccountDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text("Account successfully created"),
      content: Text(
          "Account successfully created, Kindly verify your email to login"),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  initState() {
    _userProvider = Provider.of<UserProvider>(context, listen: false);
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
              width: double.infinity,
              height: double.infinity,
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
                            'Create Account',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff01443A)),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Make an account on Venetian Pines.',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Color(0xff424847)),
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/bottom_nav/user.svg',
                                semanticsLabel: 'User',
                                width: 20,
                                height: 20,
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Text(
                                'Full Name*',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 22),
                              ),
                              Spacer(),
                              Text(
                                '*required field',
                                style: TextStyle(
                                    color: Color(0xff747474),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 19),
                              )
                            ],
                          ),
                          Container(
                            height: 60,
                            margin: EdgeInsets.only(top: 5),
                            child: Theme(
                              data: ThemeData(
                                  hintColor:
                                      nameErr ? Colors.red : Colors.black),
                              child: TextField(
                                onChanged: (val) {
                                  name = val;
                                  if (val.length > 0) {
                                    setState(() {
                                      nameErr = false;
                                    });
                                  }
                                },
                                decoration: InputDecoration(
                                    focusedBorder:
                                        nameErr ? errBorder : focusBorder,
                                    enabledBorder: nameErr
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
                                    hintText: "Enter name",
                                    fillColor: Colors.white),
                              ),
                            ),
                          ),
                          if (nameErr) errorMsg("Please provide full name"),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/bottom_nav/address.svg',
                                semanticsLabel: 'Address',
                                width: 20,
                                height: 20,
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Text(
                                'Address*',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Theme(
                              data: ThemeData(
                                  hintColor:
                                      addressErr ? Colors.red : Colors.black),
                              child: TextField(
                                onChanged: (val) {
                                  address = val;
                                  if (val.length > 0) {
                                    setState(() {
                                      addressErr = false;
                                    });
                                  }
                                },
                                minLines: null,
                                maxLines: 2,
                                textAlignVertical: TextAlignVertical.top,
                                decoration: InputDecoration(
                                    focusedBorder:
                                        addressErr ? errBorder : focusBorder,
                                    border: addressErr
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
                                    hintText: 'Enter address',
                                    fillColor: Colors.white),
                              ),
                            ),
                          ),
                          if (addressErr) errorMsg("Please provide an address"),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/bottom_nav/phone.svg',
                                semanticsLabel: 'Phone',
                                width: 20,
                                height: 20,
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Text(
                                'Phone*',
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
                              data: ThemeData(
                                  hintColor:
                                      phoneErr ? Colors.red : Colors.black),
                              child: TextField(
                                onChanged: (val) {
                                  phone = val;
                                  if (val.length > 0) {
                                    setState(() {
                                      phoneErr = false;
                                    });
                                  }
                                },
                                decoration: InputDecoration(
                                    focusedBorder:
                                        phoneErr ? errBorder : focusBorder,
                                    border: phoneErr
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
                                    hintText: "+1 000 0000 0000",
                                    fillColor: Colors.white),
                              ),
                            ),
                          ),
                          if (phoneErr) errorMsg("Please provide phone number"),
                          SizedBox(
                            height: 20,
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
                              Text(
                                'Email*',
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
                              data: ThemeData(
                                  hintColor:
                                      emailErr ? Colors.red : Colors.black),
                              child: TextField(
                                onChanged: (val) {
                                  email = val;
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
                                    hintText: "Enter email",
                                    fillColor: Colors.white),
                              ),
                            ),
                          ),
                          if (emailErr) errorMsg("Please provide email"),
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
                                'Password*',
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
                              data: ThemeData(
                                  hintColor:
                                      passErr ? Colors.red : Colors.black),
                              child: TextField(
                                obscureText: passwrod_visible1,
                                onChanged: (val) {
                                  password = val;
                                  if (val.length > 0) {
                                    setState(() {
                                      passErr = false;
                                      passEqualErr = false;
                                    });
                                  }
                                },
                                controller: pass,
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
                                    hintText: "Enter password",
                                    fillColor: Colors.white),
                              ),
                            ),
                          ),
                          passErr
                              ? errorMsg("Please provide password")
                              : passEqualErr
                                  ? errorMsg("Password aren't same")
                                  : Container(),
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
                                'Confirm Password*',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          ),
                          Container(
                            height: 60,
                            margin: EdgeInsets.only(top: 5),
                            child: Theme(
                              data: ThemeData(
                                  hintColor: cpErr ? Colors.red : Colors.black),
                              child: TextField(
                                obscureText: passwrod_visible,
                                onChanged: (val) {
                                  confirmPass = val;
                                  if (val.length > 0) {
                                    setState(() {
                                      cpErr = false;
                                      passEqualErr = false;
                                    });
                                  }
                                },
                                controller: confirm,
                                decoration: InputDecoration(
                                    focusedBorder:
                                        cpErr ? errBorder : focusBorder,
                                    border: cpErr
                                        ? errBorder
                                        : OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                    suffixIcon: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            passwrod_visible =
                                                !passwrod_visible;
                                          });
                                        },
                                        child: Icon(
                                          passwrod_visible
                                              ? Icons.visibility_off
                                              : Icons.visibility_sharp,
                                          color: Colors.black,
                                        )),
                                    filled: true,
                                    hintStyle: TextStyle(
                                        color: hintColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 19),
                                    hintText: "Re-enter password",
                                    fillColor: Colors.white),
                              ),
                            ),
                          ),
                          cpErr
                              ? errorMsg("Please provide confirm password")
                              : passEqualErr
                                  ? errorMsg("Password aren't same")
                                  : Container(),
                          SizedBox(
                            height: 20,
                          ),
                          termAndConditions(terms),
                          SizedBox(
                            height: 25,
                          ),
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                signupUser();
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
                                    'Create Account',
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
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Already have an account? ',
                                style: TextStyle(
                                    color: Color(0xff5F5F5F), fontSize: 16),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (_) => LoginPage()),
                                  );
                                },
                                child: Text(
                                  'Log in',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget termAndConditions(bool t) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Theme(
          data: Theme.of(context).copyWith(
            unselectedWidgetColor: Color(0xff01443A),
          ),
          child: Transform.scale(
            scale: 1.3,
            child: Checkbox(
              checkColor: Color(0xff01443A),
              activeColor: Color(0xff01443A).withOpacity(.6),
              value: t,
              //side: BorderSide(color: Color(0xff01443A)),
              onChanged: (bool value) {
                setState(() {
                  terms = value;
                });
              },
            ),
          ),
        ),
        Flexible(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                    text: 'I agree to the ', style: TextStyle(fontSize: 15)),
                TextSpan(
                  text: 'terms',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) =>
                                WebViewScreen(url: termsAndConditionUrl))),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                TextSpan(text: ' and ', style: TextStyle(fontSize: 15)),
                TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap =
                        () => Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => DocumentDetail(
                                  title: "Terms And Conditions",
                                  url: termsAndConditionUrl,
                                ))),
                  text: ' conditions ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                TextSpan(
                    text: ' of the platform.', style: TextStyle(fontSize: 15))
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget errorMsg(String error) {
    return Container(
      height: 35,
      margin: EdgeInsets.only(top: 8),
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
}
