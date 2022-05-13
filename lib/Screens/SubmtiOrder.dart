import 'package:flutter/material.dart';

class SubmitOrder extends StatefulWidget {
  @override
  _SubmitOrderState createState() => _SubmitOrderState();
}

class _SubmitOrderState extends State<SubmitOrder> {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          elevation: 0,
          brightness: Brightness.dark,
          backgroundColor: Colors.transparent,
          title: Text(
            'Submit Work Order',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
          ),
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          Container(
              height: 115,
              width: double.infinity,
              // color: Colors.red,
              child: Stack(children: [
                Image.asset(
                  'assets/background.png',
                  height: 115,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
                Image.asset(
                  'assets/greengrad.png',
                  height: 115,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
              ])),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 60,
            margin: EdgeInsets.only(left: 18, right: 18, top: 10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: Colors.black, // set border color
                  width: 1.0), // set border width
              borderRadius: BorderRadius.all(
                  Radius.circular(4.0)), // set rounded corner radius
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Enter Your Name',
                border: InputBorder.none,
              ),
            ),
          ),
          Container(
            height: 60,
            margin: EdgeInsets.only(left: 18, right: 18, top: 5),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: Colors.black, // set border color
                  width: 1.0), // set border width
              borderRadius: BorderRadius.all(
                  Radius.circular(4.0)), // set rounded corner radius
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Enter Order Detail',
                border: InputBorder.none,
              ),
            ),
          ),
          Container(
            height: 60,
            margin: EdgeInsets.only(left: 18, right: 18, top: 10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: Colors.black, // set border color
                  width: 1.0), // set border width
              borderRadius: BorderRadius.all(
                  Radius.circular(4.0)), // set rounded corner radius
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Enter Order Date',
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: h * 0.08,
              width: w * 0.89,
              decoration: BoxDecoration(
                color: Color(0xff01443A),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Submit Order',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
        ])));
  }
}
