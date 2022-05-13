import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:venetian_pines/Providers/UserProvider.dart';
import 'package:venetian_pines/Providers/post_provider.dart';
import 'package:venetian_pines/Screens/ChatPage/Chat.dart';
import 'package:venetian_pines/Screens/CommunityDocuments/CommunityDocuments.dart';
import 'package:venetian_pines/Screens/CreditCardPage/CreditCardPage.dart';
import 'package:venetian_pines/Screens/Maintenance/MaintenancePage.dart';
import 'package:venetian_pines/Screens/PostPage/PostPage.dart';
import 'package:venetian_pines/Screens/ReserveAmenities/ReserveAmenities.dart';
import 'package:venetian_pines/Screens/TrackOrder.dart';
import 'package:venetian_pines/Screens/ViewPayment/ViewPayment.dart';
import 'package:provider/provider.dart';
import 'package:venetian_pines/Screens/webViewScreen.dart';
import 'package:venetian_pines/main.dart';

class MyHOA extends StatefulWidget {
  final void Function(int value) changeItem;

  MyHOA({@required this.changeItem});
  @override
  _MyHOAState createState() => _MyHOAState();
}

class _MyHOAState extends State<MyHOA> with AutomaticKeepAliveClientMixin {
  var _url = 'https://google.com';
  Color textColor = Color.fromRGBO(1, 68, 58, 1);
  void _launchURL() async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';
  Border border() {
    return Border.all(
      color: Color.fromRGBO(1, 68, 58, 0.34),
      width: 1.5,
    );
  }

  UserProvider _userProvider;

  initState() {
    _userProvider = Provider.of<UserProvider>(context, listen: false);
    super.initState();
  }

  Widget appBar() {
    return Container(
      color: Color.fromRGBO(1, 68, 58, 1),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            width: 10,
          ),
          IconButton(
            icon: Icon(Icons.menu, color: Colors.white), // set your color here
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            'My HOA',
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Spacer(),
          // GestureDetector(
          //   onTap: () {
          //     widget.changeItem(4);
          //   },
          //   child: Image.asset(
          //     'assets/icons/chat.png',
          //     width: 30,
          //     height: 30,
          //   ),
          // ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final cp = context.watch<PostProivder>();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
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
                Image.asset('assets/grad_center1.png',
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.fill),
                Container(
                  height: double.infinity,
                  width: devWidth,
                  child: SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        appBar(),
                        Padding(
                          padding: EdgeInsets.only(left: 20, top: 24),
                          child: Consumer<UserProvider>(
                            builder: (ctx, userProv, _) => RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: "Hello, ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 36,
                                        color: Colors.white)),
                                TextSpan(
                                    text: "${userProv.currentUser.name}",
                                    style: TextStyle(
                                        shadows: [
                                          Shadow(
                                            offset: Offset(5, 5),
                                            blurRadius: 3.0,
                                            color: Colors.black54,
                                          ),
                                          Shadow(
                                            offset: Offset(5, 5),
                                            blurRadius: 8.0,
                                            color: Colors.black38,
                                          )
                                        ],
                                        fontWeight: FontWeight.w600,
                                        fontSize: 36,
                                        color: Colors.white))
                              ]),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(top: 20, right: 20),
                          padding: EdgeInsets.only(left: 20),
                          width: devWidth,
                          height: 40,
                          color: Color(0XFF01443A),
                          child: Text(
                            "Explore what you can do with My HOA.",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          height: devHeight * 0.13,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => WebViewScreen(
                                        url:
                                            "https://www.propertypay.cit.com/",
                                      )),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 20, right: 20),
                            height: devHeight * 0.07,
                            decoration: BoxDecoration(
                              border: border(),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 15,
                                ),
                                Image.asset(
                                  'assets/icons/hoa.png',
                                  width: 30,
                                  height: 30,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Pay My HOA',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: textColor),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: textColor,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => WebViewScreen(
                                    url: "https://www.utilitytaxservice.com/AccountSrch",
                                  )),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 20, right: 20),
                            height: devHeight * 0.07,
                            decoration: BoxDecoration(
                              border: border(),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 15,
                                ),
                                Image.asset(
                                  'assets/icons/hoa.png',
                                  width: 30,
                                  height: 30,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Pay My MUD',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: textColor),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: textColor,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // GestureDetector(
                        //   onTap: () {
                        //     Navigator.of(context).push(
                        //       MaterialPageRoute(builder: (_) => ViewPayment()),
                        //     );
                        //   },
                        //   child: Container(
                        //     margin: EdgeInsets.only(left: 20, right: 20),
                        //     height: devHeight * 0.07,
                        //     decoration: BoxDecoration(
                        //       border: border(),
                        //       color: Colors.white,
                        //       borderRadius: BorderRadius.circular(4),
                        //     ),
                        //     child: Row(
                        //       children: [
                        //         SizedBox(
                        //           width: 15,
                        //         ),
                        //         Image.asset(
                        //           'assets/icons/money.png',
                        //           width: 30,
                        //           height: 30,
                        //         ),
                        //         SizedBox(
                        //           width: 10,
                        //         ),
                        //         Text(
                        //           'View Payments',
                        //           style: TextStyle(
                        //               fontSize: 17,
                        //               fontWeight: FontWeight.bold,
                        //               color: textColor),
                        //         ),
                        //         Spacer(),
                        //         Icon(
                        //           Icons.arrow_forward_ios_rounded,
                        //           color: textColor,
                        //         ),
                        //         SizedBox(
                        //           width: 15,
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => MaintenancePage(mode: 1)),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 20, right: 20),
                            height: devHeight * 0.07,
                            decoration: BoxDecoration(
                              border: border(),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 15,
                                ),
                                SvgPicture.asset(
                                  'assets/icons/icon_wrench_green.svg',
                                  width: 30,
                                  height: 27,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Request Maintenance",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: textColor),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: textColor,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => TrackOrderList()),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 20, right: 20),
                            height: devHeight * 0.07,
                            decoration: BoxDecoration(
                              border: border(),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 15,
                                ),
                                SvgPicture.asset(
                                  'assets/icons/Stopwatch(2).svg',
                                  width: 30,
                                  height: 30,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Track My Maintenance Request",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: textColor),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: textColor,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => CommunityDocuments()),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 20, right: 20),
                            height: devHeight * 0.07,
                            decoration: BoxDecoration(
                              border: border(),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 15,
                                ),
                                Image.asset(
                                  'assets/icons/document.png',
                                  width: 25,
                                  height: 25,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Community Documents',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: textColor),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: textColor,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            widget.changeItem(10);
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 20, right: 20),
                            height: devHeight * 0.07,
                            decoration: BoxDecoration(
                              border: border(),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 15,
                                ),
                                Image.asset(
                                  'assets/icons/chat1.png',
                                  width: 30,
                                  height: 27,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Chat',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: textColor),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: textColor,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 200,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

//Scaffold(
    //     body: SingleChildScrollView(
    //         child: Column(children: [
    //   appBar(),
    //   SizedBox(
    //     height: 20,
    //   ),
    //   Container(
    //     padding: EdgeInsets.symmetric(horizontal: 10),
    //     child: Text(
    //       'Lorem ipsum dolor sit amet.',
    //       textAlign: TextAlign.center,
    //       style: TextStyle(
    //           color: textColor, fontSize: 18, fontWeight: FontWeight.bold),
    //     ),
    //   ),
    //   SizedBox(
    //     height: 30,
    //   ),
    //   GestureDetector(
    //     onTap: () {
    //       Navigator.of(context).push(
    //         MaterialPageRoute(builder: (_) => CreditCardPage()),
    //       );
    //     },
    //     child: Container(
    //       margin: EdgeInsets.only(left: 20, right: 20),
    //       height: h * 0.07,
    //       decoration: BoxDecoration(
    //         border: border(),
    //         borderRadius: BorderRadius.circular(4),
    //       ),
    //       child: Row(
    //         children: [
    //           SizedBox(
    //             width: 15,
    //           ),
    //           Image.asset(
    //             'assets/icons/hoa.png',
    //             width: 30,
    //             height: 30,
    //           ),
    //           SizedBox(
    //             width: 10,
    //           ),
    //           Text(
    //             'Pay My HOA',
    //             style: TextStyle(
    //                 fontSize: 17,
    //                 fontWeight: FontWeight.bold,
    //                 color: textColor),
    //           ),
    //           Spacer(),
    //           Icon(
    //             Icons.arrow_forward_ios_rounded,
    //             color: textColor,
    //           ),
    //           SizedBox(
    //             width: 15,
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    //   SizedBox(
    //     height: 10,
    //   ),
    //   GestureDetector(
    //     onTap: () {
    //       Navigator.of(context).push(
    //         MaterialPageRoute(builder: (_) => ViewPayment()),
    //       );
    //     },
    //     child: Container(
    //       margin: EdgeInsets.only(left: 20, right: 20),
    //       height: h * 0.07,
    //       decoration: BoxDecoration(
    //         border: border(),
    //         borderRadius: BorderRadius.circular(4),
    //       ),
    //       child: Row(
    //         children: [
    //           SizedBox(
    //             width: 15,
    //           ),
    //           Image.asset(
    //             'assets/icons/money.png',
    //             width: 30,
    //             height: 30,
    //           ),
    //           SizedBox(
    //             width: 10,
    //           ),
    //           Text(
    //             'View Payments',
    //             style: TextStyle(
    //                 fontSize: 17,
    //                 fontWeight: FontWeight.bold,
    //                 color: textColor),
    //           ),
    //           Spacer(),
    //           Icon(
    //             Icons.arrow_forward_ios_rounded,
    //             color: textColor,
    //           ),
    //           SizedBox(
    //             width: 15,
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    //   SizedBox(
    //     height: 10,
    //   ),
    //   GestureDetector(
    //     onTap: () {
    //       Navigator.of(context).push(
    //         MaterialPageRoute(builder: (_) => MaintenancePage(mode: 1)),
    //       );
    //     },
    //     child: Container(
    //       margin: EdgeInsets.only(left: 20, right: 20),
    //       height: h * 0.07,
    //       decoration: BoxDecoration(
    //         border: border(),
    //         borderRadius: BorderRadius.circular(4),
    //       ),
    //       child: Row(
    //         children: [
    //           SizedBox(
    //             width: 15,
    //           ),
    //           Image.asset(
    //             'assets/icons/submit.png',
    //             width: 30,
    //             height: 27,
    //           ),
    //           SizedBox(
    //             width: 10,
    //           ),
    //           Text(
    //             "Request Maintenance",
    //             style: TextStyle(
    //                 fontSize: 17,
    //                 fontWeight: FontWeight.bold,
    //                 color: textColor),
    //           ),
    //           Spacer(),
    //           Icon(
    //             Icons.arrow_forward_ios_rounded,
    //             color: textColor,
    //           ),
    //           SizedBox(
    //             width: 15,
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    //   SizedBox(
    //     height: 10,
    //   ),
    //   GestureDetector(
    //     onTap: () {
    //       Navigator.of(context).push(
    //         MaterialPageRoute(builder: (_) => TrackOrderList()),
    //       );
    //     },
    //     child: Container(
    //       margin: EdgeInsets.only(left: 20, right: 20),
    //       height: h * 0.07,
    //       decoration: BoxDecoration(
    //         border: border(),
    //         borderRadius: BorderRadius.circular(4),
    //       ),
    //       child: Row(
    //         children: [
    //           SizedBox(
    //             width: 15,
    //           ),
    //           Image.asset(
    //             'assets/icons/work_order.png',
    //             width: 30,
    //             height: 27,
    //           ),
    //           SizedBox(
    //             width: 10,
    //           ),
    //           Text(
    //             "Track My Maintenance Request",
    //             style: TextStyle(
    //                 fontSize: 17,
    //                 fontWeight: FontWeight.bold,
    //                 color: textColor),
    //           ),
    //           Spacer(),
    //           Icon(
    //             Icons.arrow_forward_ios_rounded,
    //             color: textColor,
    //           ),
    //           SizedBox(
    //             width: 15,
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    //   SizedBox(
    //     height: 10,
    //   ),
    //   GestureDetector(
    //     onTap: () {
    //       Navigator.of(context).push(
    //         MaterialPageRoute(
    //             builder: (_) =>PostPage(
    //               context: context,
    //               type: "5",
    //             ),
    //       ));
    //     },
    //     child: Container(
    //       margin: EdgeInsets.only(left: 20, right: 20),
    //       height: h * 0.07,
    //       decoration: BoxDecoration(
    //         border: border(),
    //         borderRadius: BorderRadius.circular(4),
    //       ),
    //       child: Row(
    //         children: [
    //           SizedBox(
    //             width: 15,
    //           ),
    //           Image.asset(
    //             'assets/icons/work_order.png',
    //             width: 30,
    //             height: 27,
    //           ),
    //           SizedBox(
    //             width: 10,
    //           ),
    //           Text(
    //             'Reserve Amenities',
    //             style: TextStyle(
    //                 fontSize: 17,
    //                 fontWeight: FontWeight.bold,
    //                 color: textColor),
    //           ),
    //           Spacer(),
    //           Icon(
    //             Icons.arrow_forward_ios_rounded,
    //             color: textColor,
    //           ),
    //           SizedBox(
    //             width: 15,
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    //   SizedBox(height: 10),
    //   GestureDetector(
    //     onTap: () {
    //       Navigator.of(context).push(
    //         MaterialPageRoute(builder: (_) => CommunityDocuments()),
    //       );
    //     },
    //     child: Container(
    //       margin: EdgeInsets.only(left: 20, right: 20),
    //       height: h * 0.07,
    //       decoration: BoxDecoration(
    //         border: border(),
    //         borderRadius: BorderRadius.circular(4),
    //       ),
    //       child: Row(
    //         children: [
    //           SizedBox(
    //             width: 15,
    //           ),
    //           Image.asset(
    //             'assets/icons/document.png',
    //             width: 25,
    //             height: 25,
    //           ),
    //           SizedBox(
    //             width: 10,
    //           ),
    //           Text(
    //             'Community Documents',
    //             style: TextStyle(
    //                 fontSize: 17,
    //                 fontWeight: FontWeight.bold,
    //                 color: textColor),
    //           ),
    //           Spacer(),
    //           Icon(
    //             Icons.arrow_forward_ios_rounded,
    //             color: textColor,
    //           ),
    //           SizedBox(
    //             width: 15,
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    //   SizedBox(
    //     height: 10,
    //   ),
    //   GestureDetector(
    //     onTap: () {
    //       widget.changeItem(4);
    //     },
    //     child: Container(
    //       margin: EdgeInsets.only(left: 20, right: 20),
    //       height: h * 0.07,
    //       decoration: BoxDecoration(
    //         border: border(),
    //         borderRadius: BorderRadius.circular(4),
    //       ),
    //       child: Row(
    //         children: [
    //           SizedBox(
    //             width: 15,
    //           ),
    //           Image.asset(
    //             'assets/icons/chat1.png',
    //             width: 30,
    //             height: 27,
    //           ),
    //           SizedBox(
    //             width: 10,
    //           ),
    //           Text(
    //             'Chat',
    //             style: TextStyle(
    //                 fontSize: 17,
    //                 fontWeight: FontWeight.bold,
    //                 color: textColor),
    //           ),
    //           Spacer(),
    //           Icon(
    //             Icons.arrow_forward_ios_rounded,
    //             color: textColor,
    //           ),
    //           SizedBox(
    //             width: 15,
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    //   SizedBox(
    //     height: 10,
    //   ),
    //   // GestureDetector(
    //   //   onTap: () {
    //   //     _launchURL();
    //   //   },
    //   //   child: Container(
    //   //     width: w * 0.9,
    //   //     height: h * 0.07,
    //   //     decoration: BoxDecoration(
    //   //       border: border(),
    //   //       borderRadius: BorderRadius.circular(4),
    //   //     ),
    //   //     child: Row(
    //   //       children: [
    //   //         SizedBox(
    //   //           width: 15,
    //   //         ),
    //   //         Image.asset(
    //   //           'assets/icons/help.png',
    //   //           width: 30,
    //   //           height: 27,
    //   //         ),
    //   //         SizedBox(
    //   //           width: 10,
    //   //         ),
    //   //         Text(
    //   //           'Help',
    //   //           style: TextStyle(
    //   //               fontSize: 15,
    //   //               fontWeight: FontWeight.bold,
    //   //               color: textColor),
    //   //         ),
    //   //         Spacer(),
    //   //         Icon(
    //   //           Icons.arrow_forward_ios_rounded,
    //   //           color: textColor,
    //   //         ),
    //   //         SizedBox(
    //   //           width: 15,
    //   //         ),
    //   //       ],
    //   //     ),
    //   //   ),
    //   // ),
    // ])));
