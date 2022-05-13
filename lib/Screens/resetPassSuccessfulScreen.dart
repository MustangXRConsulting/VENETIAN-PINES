import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:venetian_pines/main.dart';

class ResetPassSuccessfulScreen extends StatelessWidget {
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
                        padding: const EdgeInsets.only(left: 18.0, top: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Create a New Password',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff01443A)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Need a new password? Please enter your email below to continue. We’ll email you a link to make a new one.",
                              style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(66, 72, 71, 1)),
                            ),
                            SizedBox(
                              height: 32,
                            ),
                            GestureDetector(
                              onTap: ()=>Navigator.of(context).pop(),
                              child: Container(
                                height: devHeight * 0.08,
                                width: devWidth * 0.89,
                                decoration: BoxDecoration(
                                  color: Color(0xff01443A),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Center(
                                  child: Text(
                                    'Back to Sign In',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
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
