import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:venetian_pines/Providers/UserProvider.dart';
import 'package:venetian_pines/Screens/Login/LoginPage.dart';
import 'package:venetian_pines/Screens/MultiNavHome/MultiNavHome.dart';
import 'package:venetian_pines/Screens/Splash/GetStarted.dart';

import '../../main.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void checkConfigs() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    //sharedPref.remove('user');
    if (!sharedPref.containsKey('user')) {
      // no login
      if (sharedPref.getString('welcomed') != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => GuidingScreens()),
        );
      }
    } else {
      // logged in
      await Provider.of<UserProvider>(context, listen: false).fetchLocal();
      Navigator.pushReplacement(
        context,
        // MaterialPageRoute(builder: (context) => HomePage()),
        MaterialPageRoute(builder: (context) => MultiNavHome()),
      );
    }
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    Future.delayed(Duration(seconds: 2), () {
      devHeight = MediaQuery.of(context).size.height;
      devWidth = MediaQuery.of(context).size.width;
      checkConfigs();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Image.asset(
              'assets/bg.png',
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
            Image.asset('assets/newGrad.png',
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.fill),
            Container(
              color: Colors.black.withOpacity(.2),
              height: double.infinity,
              width: double.infinity,
            ),
            Positioned(
                top: h * 0.4,
                child: Container(
                  width: w,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: SvgPicture.asset(
                          'assets/bottom_nav/logo.svg',
                          width: w * .4,
                          height: w * .4,
                          semanticsLabel: 'Close',
                        ),
                      )
                    ],
                  ),
                )),
            Positioned(
                top: h * 0.84,
                left: w * .45,
                child: SpinKitCircle(
                  size: 35,
                  color: Color(0xff01443A),
                )),
          ],
        ),
      ),
    );
  }
}

class GuidingScreens extends StatefulWidget {
  const GuidingScreens({Key key}) : super(key: key);

  @override
  _GuidingScreensState createState() => _GuidingScreensState();
}

class _GuidingScreensState extends State<GuidingScreens> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Image.asset(
              'assets/bg.png',
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
            Image.asset('assets/newGrad.png',
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.fill),
            // Positioned(
            //   top: h * 0.06,
            //   left: w * 0.8,
            //   child: GestureDetector(
            //     onTap: () async {
            //       await Provider.of<UserProvider>(context, listen: false)
            //           .welcomedUser();
            //       Navigator.of(context).pushReplacement(
            //         MaterialPageRoute(builder: (_) => LoginPage()),
            //       );
            //     },
            //     child: Row(
            //       children: [
            //         Text(
            //           'Skip',
            //           style: TextStyle(
            //               color: Color.fromRGBO(1, 68, 58, 1),
            //               fontWeight: FontWeight.bold,
            //               fontSize: 16),
            //         ),
            //         Icon(
            //           Icons.arrow_right_alt,
            //           color: Color.fromRGBO(1, 68, 58, 1),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            Positioned(
                top: h * 0.3,
                child: Container(
                  width: w,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/bottom_nav/logo.svg',
                        width: w * .4,
                        height: w * .4,
                        semanticsLabel: 'Close',
                      )
                    ],
                  ),
                )),
            Positioned(
              top: h * 0.55,
              child: Container(
                width: w,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        'Stay Up To Date:',
                        style: TextStyle(
                            color: Color(0xff01443A),
                            fontWeight: FontWeight.bold,
                            fontSize: 24),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
                top: h * 0.6,
                child: Container(
                  width: w,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'Pay your HOA dues, discover local activities and stay up to date with exciting events happening in your community.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0xff01443A),
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  ),
                )),
            Positioned(
                top: h * 0.8,
                left: w * 0.07,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => LoginPage()),
                    );
                  },
                  child: Container(
                    height: h * 0.08,
                    width: w * 0.86,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0xff01443A),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'Next',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
