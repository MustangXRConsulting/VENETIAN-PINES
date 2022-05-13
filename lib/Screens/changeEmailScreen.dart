import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:venetian_pines/Providers/UserProvider.dart';
import 'package:venetian_pines/Screens/resetPasswordScreen.dart';

class ChangeEmailScreen extends StatefulWidget {
  @override
  _ChangeEmailScreenState createState() => _ChangeEmailScreenState();
}

class _ChangeEmailScreenState extends State<ChangeEmailScreen> {
  OutlineInputBorder focusBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
    borderSide: BorderSide(width: 1, color: Colors.black),
  );

  Color hintColor = Color(0xff747474);

  UserProvider userProvider;

  TextEditingController emailController = TextEditingController();

  bool isUpdating = false;
  @override
  void initState() {
    userProvider = Provider.of<UserProvider>(context, listen: false);
    emailController =
        TextEditingController(text: userProvider.currentUser.email);
    super.initState();
  }

  onUpdate() async {
    try {
      if (emailController.text.trim().isEmpty)
        return Toast.show("Email cannot be empty", context);
      if (!isEmailValid(emailController.text.trim()))
        Toast.show("Invalid Email", context);

      setState(() => isUpdating = true);
      await FirebaseAuth.instance.currentUser
          .updateEmail(emailController.text.trim());

      await FirebaseAuth.instance.currentUser.sendEmailVerification();

      await userProvider.updateEmail(email: emailController.text.trim());

      Toast.show("Email updated", context);
    } catch (e) {
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
                            "Update Email",
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
                              data: ThemeData(hintColor: Colors.black),
                              child: TextField(
                                controller: emailController,
                                decoration: InputDecoration(
                                    focusedBorder: focusBorder,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
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
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: GestureDetector(
                              onTap: onUpdate,
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
                                          'Update Email',
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
      ),
    );
  }
}
