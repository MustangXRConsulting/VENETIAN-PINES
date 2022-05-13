import 'package:flutter/material.dart';

class ThankyouPage extends StatefulWidget {
  const ThankyouPage({Key key}) : super(key: key);

  @override
  _ThankyouPageState createState() => _ThankyouPageState();
}

class _ThankyouPageState extends State<ThankyouPage> {
  double w, h;

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xff01443a),
      body: Container(
        width: w,
        height: h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: w * .3,
              height: w * .3,
              decoration: BoxDecoration(
                  color: Color(0xffe8a444), shape: BoxShape.circle),
              child: Center(
                child: Icon(
                  Icons.check,
                  color: Color(0xfff7f4e5),
                  size: 35,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Thank You",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 26),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "We've received your request. We'll get back to you as soon as possible.",
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
            ),
            SizedBox(
              height: h * .1,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: w * .1, vertical: 8),
                decoration: BoxDecoration(
                    color: Color(0xfff7f4e5),
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Text(
                  "Back",
                  style: TextStyle(color: Colors.black,fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
