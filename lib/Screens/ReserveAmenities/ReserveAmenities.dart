import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart' as http;
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:venetian_pines/Providers/maintenance_provider.dart';
import 'package:venetian_pines/Screens/ChatPage/Chat.dart';
import 'package:venetian_pines/Screens/thankyou/thankyou.dart';

class ReserveAmentities extends StatefulWidget {
  String title;
  DateTime eventDate;
  String img;
  double h, w;
  final String description;

  ReserveAmentities({this.title, this.eventDate, this.img, this.h, this.w,@required this.description});
  @override
  _ReserveAmentitiesState createState() => _ReserveAmentitiesState();
}

class _ReserveAmentitiesState extends State<ReserveAmentities> {
  String name, address, issue;
  DateTime dateTime = null;
  bool submit = false;
  TextEditingController nameC = new TextEditingController();
  TextEditingController addressC = new TextEditingController();
  TextEditingController issueC = new TextEditingController();
  String category;
  bool loading = true;

  Uint8List list;

  showPicker() {
    FocusScope.of(context).unfocus();
    DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: DateTime(2010, 1, 1),
        maxTime: DateTime(2030, 1, 1),
        theme: DatePickerTheme(
            headerColor: Color(0xff01443A),
            backgroundColor: Color(0xff01443A),
            cancelStyle: TextStyle(color: Colors.white, fontSize: 18),
            itemStyle: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
            doneStyle: TextStyle(color: Colors.white, fontSize: 18)),
        onChanged: (date) {}, onConfirm: (date) {
      setState(() {
        dateTime = date;
      });
    });
  }

  Future<Uint8List> resizeImage({double w, double h}) async {
    http.Response response = await http.get(Uri.parse(widget.img));
    list = response.bodyBytes;
    var result = await FlutterImageCompress.compressWithList(
      list,
      minHeight: (widget.h * .25).toInt(),
      minWidth: widget.w.toInt(),
      quality: 96,
      rotate: 0,
    );
    return result;
  }

  Border border() {
    return Border.all(
        color: Color.fromRGBO(1, 68, 58, 0.34), // set border color
        width: 1.5);
  }

  resize() async {
    await resizeImage();
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    resize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
        // extendBodyBehindAppBar: true,
        // extendBody: true,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back,
                color: Colors.white), // set your color here
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: Color.fromRGBO(1, 68, 58, 1),
          title: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                'Reserve ${widget.title}',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Spacer(),
            ],
          ),
        ),
        body: Column(children: [
          SizedBox(
            height: 10,
          ),
          !loading
              ? Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        children: [
                          Container(
                              height: h * 0.25,
                              width: double.infinity,

                              // color: Colors.red,
                              child: Image.memory(
                                list,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.fitWidth,
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            widget.description,
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 55,
                            margin: EdgeInsets.only(top: 5),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: border(), // set border width
                              borderRadius: BorderRadius.all(Radius.circular(
                                  4.0)), // set rounded corner radius
                            ),
                            child: TextField(
                              controller: nameC,
                              onChanged: (val) {
                                name = val;
                              },
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                                contentPadding:
                                    EdgeInsets.only(top: 10.0, bottom: 10.0),
                                hintText: 'Full Name',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Container(
                            height: 55,
                            margin: EdgeInsets.only(top: 10),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: border(), // set border width
                              borderRadius: BorderRadius.all(Radius.circular(
                                  4.0)), // set rounded corner radius
                            ),
                            child: TextField(
                              controller: addressC,
                              onChanged: (val) {
                                address = val;
                              },
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                                contentPadding:
                                    EdgeInsets.only(top: 10.0, bottom: 10.0),
                                hintText: 'Enter email address',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Container(
                            height: 100,
                            margin: EdgeInsets.only(top: 10),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: border(), // set border width
                              borderRadius: BorderRadius.all(Radius.circular(
                                  4.0)), // set rounded corner radius
                            ),
                            child: TextField(
                              keyboardType: TextInputType.multiline,
                              minLines: 3,
                              maxLines: 3,
                              controller: issueC,
                              onChanged: (val) {
                                issue = val;
                                issue = issue.trim();
                              },
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                                contentPadding: EdgeInsets.only(bottom: 10.0),
                                hintText: 'Message',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (!submit) {
                                if (nameC.text.isEmpty ||
                                    addressC.text.isEmpty) {
                                  Toast.show(
                                      "All fields are required!", context);
                                  return;
                                }
                                setState(() {
                                  submit = true;
                                });
                                SharedPreferences sharedPref =
                                    await SharedPreferences.getInstance();
                                // save request
                                Map<String, dynamic> data = {
                                  'name': name,
                                  'address': address,
                                  'amenity': widget.title,
                                  'email': sharedPref.getString('user'),
                                  'message': issue,
                                  'dateCreated': widget.eventDate
                                };
                                bool created =
                                    await Provider.of<MaintenanceProvider>(
                                            context,
                                            listen: false)
                                        .createAmenity(data);
                                if (created) {
                                  Toast.show("Successfully sent!", context);
                                  FocusScope.of(context).unfocus();
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ThankyouPage()),
                                  );
                                  nameC.clear();
                                  issueC.clear();
                                  addressC.clear();
                                  setState(() {
                                    dateTime = null;
                                  });
                                } else {
                                  Toast.show("Failed to sent!", context);
                                }
                                setState(() {
                                  submit = false;
                                });
                              }
                            },
                            child: Container(
                              height: 52,
                              width: w * 0.89,
                              decoration: BoxDecoration(
                                color: Color(0xff01443A),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: !submit
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Reserve',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color: Colors.white,
                                          size: 20,
                                        )
                                      ],
                                    )
                                  : progress(),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : progress()
        ]));
  }

  Widget progress() {
    return Center(
      child: NutsActivityIndicator(
          radius: 12,
          activeColor: Color(0xff447727).withOpacity(.6),
          inactiveColor: Color(0xff447727).withOpacity(.2),
          tickCount: 11,
          startRatio: 0.55,
          animationDuration: Duration(milliseconds: 600)),
    );
  }
}
