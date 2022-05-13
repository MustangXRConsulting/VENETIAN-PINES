import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:venetian_pines/Models/maintenance_model.dart';
import 'package:venetian_pines/Providers/maintenance_provider.dart';
import 'package:venetian_pines/Screens/ChatPage/Chat.dart';
import 'package:venetian_pines/Screens/thankyou/thankyou.dart';

class MaintenancePage extends StatefulWidget {
  int mode;
  MaintenancePage({this.mode});
  @override
  _MaintenancePageState createState() => _MaintenancePageState();
}

class _MaintenancePageState extends State<MaintenancePage> {
  String name, address, issue;
  DateTime dateTime = null;
  bool submit = false;
  TextEditingController nameC = new TextEditingController();
  TextEditingController addressC = new TextEditingController();
  TextEditingController issueC = new TextEditingController();

  List<String> categories = [];

  initState() {
    Future.delayed(Duration(seconds: 0), () async {
      final response = await FirebaseFirestore.instance
          .collection("maintainenceCat")
          .orderBy("date", descending: true)
          .get();

      for (DocumentSnapshot doc in response.docs) categories.add(doc["name"]);

      setState(() {});
    });
    super.initState();
  }

  String category;
  showPicker() {
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

  Border border() {
    return Border.all(
        color: Color.fromRGBO(1, 68, 58, 0.34), // set border color
        width: 1.5);
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          leading: Container(
            margin: EdgeInsets.only(left: 10),
            child: IconButton(
              icon: Icon(widget.mode != null ? Icons.arrow_back : Icons.menu,
                  color: Colors.white), // set your color here
              onPressed: () {
                if (widget.mode != null)
                  Navigator.of(context).pop();
                else
                  Scaffold.of(context).openDrawer();
              },
            ),
          ),
          backgroundColor: Color.fromRGBO(1, 68, 58, 1),
          title: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                'Maintenance Request',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChatScreen(
                                peerId: 'admin@admin.com',
                                peerAvatar: '',
                                peerName: 'admin',
                                mode: 1,
                              )));
                },
                child: Image.asset(
                  'assets/icons/chat.png',
                  width: 30,
                  height: 30,
                ),
              )
            ],
          ),
        ),
        body: Column(children: [
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    // Padding(
                    //   padding: EdgeInsets.only(top: 5),
                    //   child: Text(
                    //     'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In dictum aliquet malesuada aliquam non tristique parturient nec. Sed vitae pretium, aliquam posuere leo gravida proin nulla. In duis elit sit maecenas nunc consectetur. Sed at bibendum posuere amet.',
                    //     style: TextStyle(fontSize: 14),
                    //     textAlign: TextAlign.justify,
                    //   ),
                    // ),
                    heading(),
                    SizedBox(
                      height: 29,
                    ),
                    Container(
                      height: 55,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: border(), // set border width
                        borderRadius: BorderRadius.all(
                            Radius.circular(4.0)), // set rounded corner radius
                      ),
                      child: Center(
                        child: TextField(
                          textAlignVertical: TextAlignVertical.center,
                          controller: nameC,
                          onChanged: (val) {
                            name = val;
                          },
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.only(top: 10.0, bottom: 10.0),
                            hintText: 'Full Name',
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
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
                        borderRadius: BorderRadius.all(
                            Radius.circular(4.0)), // set rounded corner radius
                      ),
                      child: TextField(
                        controller: addressC,
                        onChanged: (val) {
                          address = val;
                        },
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.only(top: 10.0, bottom: 10.0),
                          hintText: 'Enter Address',
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Container(
                      height: 55,
                      margin: EdgeInsets.only(top: 10),
                      padding: EdgeInsets.all(10),
                      width: w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: border(), // set border width
                        borderRadius: BorderRadius.all(
                            Radius.circular(4.0)), // set rounded corner radius
                      ),
                      child: Center(
                        child: DropdownButton<String>(
                          hint: Text(
                            'Choose Category',
                            style: TextStyle(
                                color: category == null
                                    ? Colors.grey
                                    : Colors.black,
                                fontWeight: category == null
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                fontSize: 16),
                          ),
                          value: category,
                          underline: Container(),
                          isExpanded: true,
                          items: categories.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (val) {
                            setState(() {
                              category = val;
                            });
                          },
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
                        borderRadius: BorderRadius.all(
                            Radius.circular(4.0)), // set rounded corner radius
                      ),
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        minLines: 3,
                        maxLines: 3,
                        controller: issueC,
                        onChanged: (val) {
                          issue = val;
                        },
                        decoration: InputDecoration(
                            hintText: 'Describe Issue',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(bottom: 10.0),
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 16)),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (!submit) {
                          if (nameC.text.isEmpty ||
                              issueC.text.isEmpty ||
                              addressC.text.isEmpty ||
                              category == null) {
                            Toast.show("All fields are required!", context);
                            return;
                          }
                          setState(() {
                            submit = true;
                          });
                          SharedPreferences sharedPref =
                              await SharedPreferences.getInstance();
                          issue = issue.toString().trim();
                          // save request
                          MaintenanceModel m = new MaintenanceModel(
                              name: name,
                              address: address,
                              category: category,
                              issue: issue,
                              email: sharedPref.getString('user'),
                              dateCreated: DateTime.now());
                          bool created = await Provider.of<MaintenanceProvider>(
                                  context,
                                  listen: false)
                              .createMaintenance(m);
                          if (created) {
                            Toast.show("Successfully sent!", context);
                            FocusScope.of(context).unfocus();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ThankyouPage()),
                            );
                            nameC.clear();
                            issueC.clear();
                            addressC.clear();
                            setState(() {
                              category = null;
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
                        decoration: BoxDecoration(
                          color: Color(0xff01443A),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: !submit
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Send Request',
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
        ]));
  }

  Widget heading() {
    return Container(
      padding: EdgeInsets.only(top: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Maintenance Request Form",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
              "Please fill out the form below and provide us with the information regarding your request. We’ll get back to you as quickly as possible. Thanks!"),
        ],
      ),
    );
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
