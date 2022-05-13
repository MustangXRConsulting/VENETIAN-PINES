import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:venetian_pines/Providers/UserProvider.dart';
import 'package:venetian_pines/Screens/CommunityDocuments/CommunityDocuments.dart';
import 'package:venetian_pines/Screens/Login/LoginPage.dart';
import 'package:venetian_pines/Screens/PostPage/PostPage.dart';
import 'package:venetian_pines/Screens/changeEmailScreen.dart';
import 'package:venetian_pines/Screens/changePasswordScreen.dart';
import 'package:venetian_pines/Screens/updateInfoScreen.dart';
import 'package:venetian_pines/Screens/webViewScreen.dart';
import 'package:venetian_pines/constant.dart';

class DrawerNav extends StatefulWidget {
  Function changeItem;
  int selected;
  DrawerNav({Key key, this.changeItem, this.selected}) : super(key: key);

  @override
  _DrawerNavState createState() => _DrawerNavState();
}

class _DrawerNavState extends State<DrawerNav> {
  UserProvider _userProvider;

  initState() {
    _userProvider = Provider.of<UserProvider>(context, listen: false);
    super.initState();
  }

  bool myAccountExpanded = true;
  bool communityExpanded = true;
  bool supportExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Container(
          width: MediaQuery.of(context).size.width / 4 * 3,
          height: MediaQuery.of(context).size.height,
          child: Drawer(
            child: Container(
              width: MediaQuery.of(context).size.width / 4 * 3,
              height: MediaQuery.of(context).size.height,
              color: Color(0xff01443A),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Consumer<UserProvider>(
                        builder: (ctx, userProv, _) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 120,
                              child: DrawerHeader(
                                decoration: BoxDecoration(
                                  color: Color(0xff01443A),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: SvgPicture.asset(
                                        'assets/icons/VenetianPines-logo-horz-white.svg',
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 12),
                                        child: SvgPicture.asset(
                                          'assets/bottom_nav/cross.svg',
                                          color: Colors.white,
                                          semanticsLabel: 'Close',
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 18),
                                child: RichText(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: "Welcome, ",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20)),
                                    TextSpan(
                                        text:
                                            userProv.currentUser.name ?? "N/A",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ))
                                  ]),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 18),
                              child: Text(userProv.currentUser.email ?? "N/A",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16)),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Theme(
                              data: ThemeData().copyWith(
                                  dividerColor:
                                      Colors.transparent.withOpacity(0)),
                              child: ExpansionTile(
                                title: Text(
                                  'My Account',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                onExpansionChanged: (val) =>
                                    setState(() => myAccountExpanded = val),
                                expandedCrossAxisAlignment:
                                    CrossAxisAlignment.start,
                                expandedAlignment: Alignment.topLeft,
                                initiallyExpanded: myAccountExpanded,
                                childrenPadding:
                                    EdgeInsets.symmetric(horizontal: 20),
                                trailing: Icon(
                                    myAccountExpanded
                                        ? Icons.keyboard_arrow_up
                                        : Icons.keyboard_arrow_down,
                                    color: Colors.white),
                                children: [
                                  Divider(
                                      color: Colors.white.withOpacity(0.25)),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                      widget.changeItem(6);
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 15),
                                      child: Text(
                                        'My HOA',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    ),
                                  ),
                                  Divider(
                                      color: Colors.white.withOpacity(0.25)),
                                  GestureDetector(
                                    onTap: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                UpdateInfoScreen())),
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 15),
                                      child: Text(
                                        'Info',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    ),
                                  ),
                                  Divider(
                                      color: Colors.white.withOpacity(0.25)),
                                  GestureDetector(
                                    onTap: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                ChangeEmailScreen())),
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 15),
                                      child: Text(
                                        'Update Email',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    ),
                                  ),
                                  Divider(
                                      color: Colors.white.withOpacity(0.25)),
                                  GestureDetector(
                                    onTap: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                ChangePasswordScreen())),
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 15),
                                      child: Text(
                                        'Change Password',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    ),
                                  ),
                                  Divider(color: Colors.white.withOpacity(0.25))
                                ],
                              ),
                            ),
                            Theme(
                              data: ThemeData().copyWith(
                                  dividerColor:
                                      Colors.transparent.withOpacity(0)),
                              child: ExpansionTile(
                                title: Text(
                                  'Community',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                onExpansionChanged: (val) =>
                                    setState(() => communityExpanded = val),
                                expandedCrossAxisAlignment:
                                    CrossAxisAlignment.start,
                                expandedAlignment: Alignment.topLeft,
                                childrenPadding:
                                    EdgeInsets.symmetric(horizontal: 20),
                                initiallyExpanded: communityExpanded,
                                trailing: Icon(
                                    communityExpanded
                                        ? Icons.keyboard_arrow_up
                                        : Icons.keyboard_arrow_down,
                                    color: Colors.white),
                                children: [
                                  Divider(
                                      color: Colors.white.withOpacity(0.25)),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  CommunityDocuments()));
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 15),
                                      child: Text(
                                        'HOA Documents',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    ),
                                  ),
                                  Divider(
                                      color: Colors.white.withOpacity(0.25)),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  PostPage(
                                                    context: context,
                                                    type: "6",
                                                  )));
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 15),
                                      child: Text(
                                        'Event Calendar',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    ),
                                  ),
                                  Divider(
                                      color: Colors.white.withOpacity(0.25)),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                      widget.changeItem(0);
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 15),
                                      child: Text(
                                        'Community News',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    ),
                                  ),
                                  Divider(
                                      color: Colors.white.withOpacity(0.25)),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                      widget.changeItem(3);
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 15),
                                      child: Text(
                                        'Marketplace',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    ),
                                  ),
                                  Divider(color: Colors.white.withOpacity(0.25))
                                ],
                              ),
                            ),
                            // Divider(
                            //   indent: 20,
                            //   endIndent: 20,
                            //   color: Colors.grey,
                            // ),
                            // ListTile(
                            //   title: Text(
                            //     'Community News',
                            //     style: TextStyle(color: Colors.white, fontSize: 20),
                            //   ),
                            //   trailing: Icon(
                            //     Icons.arrow_forward_ios_rounded,
                            //     size: 20,
                            //     color: Colors.white,
                            //   ),
                            //   onTap: () {
                            //     Navigator.pop(context);
                            //     widget.changeItem(0);
                            //   },
                            // ),
                            // Divider(
                            //   indent: 20,
                            //   endIndent: 20,
                            //   color: Colors.grey,
                            // ),
                            // ListTile(
                            //   title: Text(
                            //     'Homeowner Services',
                            //     style: TextStyle(color: Colors.white, fontSize: 20),
                            //   ),
                            //   trailing: Icon(
                            //     Icons.arrow_forward_ios_rounded,
                            //     size: 20,
                            //     color: Colors.white,
                            //   ),
                            //   onTap: () {
                            //     Navigator.pop(context);
                            //     changeItem(2);
                            //   },
                            // ),
                            // Divider(
                            //   indent: 20,
                            //   endIndent: 20,
                            //   color: Colors.grey,
                            // ),
                            // ListTile(
                            //   title: Text(
                            //     'Marketplace',
                            //     style: TextStyle(color: Colors.white, fontSize: 20),
                            //   ),
                            //   trailing: Icon(
                            //     Icons.arrow_forward_ios_rounded,
                            //     size: 20,
                            //     color: Colors.white,
                            //   ),
                            //   onTap: () {
                            //     Navigator.pop(context);
                            //     widget.changeItem(3);
                            //   },
                            // ),
                            // Divider(
                            //   indent: 20,
                            //   endIndent: 20,
                            //   color: Colors.grey,
                            // ),
                            Theme(
                              data: ThemeData().copyWith(
                                  dividerColor:
                                      Colors.transparent.withOpacity(0)),
                              child: ExpansionTile(
                                title: Text(
                                  'Support',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                onExpansionChanged: (val) =>
                                    setState(() => supportExpanded = val),
                                expandedCrossAxisAlignment:
                                    CrossAxisAlignment.start,
                                expandedAlignment: Alignment.topLeft,
                                childrenPadding:
                                    EdgeInsets.symmetric(horizontal: 20),
                                initiallyExpanded: supportExpanded,
                                trailing: Icon(
                                    supportExpanded
                                        ? Icons.keyboard_arrow_up
                                        : Icons.keyboard_arrow_down,
                                    color: Colors.white),
                                children: [
                                  Divider(
                                      color: Colors.white.withOpacity(0.25)),
                                  GestureDetector(
                                    onTap: () {
                                       Navigator.of(context).push(MaterialPageRoute(builder: (_)=>
                                      WebViewScreen(url:contactUsUrl ,)));
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 15),
                                      child: Text(
                                        'Contact Us',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    ),
                                  ),
                                  Divider(
                                      color: Colors.white.withOpacity(0.25)),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (_) => WebViewScreen(
                                                  url: termsAndConditionUrl)));
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 15),
                                      child: Text(
                                        'Legal',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    ),
                                  ),
                                  Divider(color: Colors.white.withOpacity(0.25))
                                ],
                              ),
                            ),
                            // ListTile(
                            //   title: Text(
                            //     'Reserve Amenities',
                            //     style: TextStyle(color: Colors.white, fontSize: 20),
                            //   ),
                            //   trailing: Icon(
                            //     Icons.arrow_forward_ios_rounded,
                            //     size: 20,
                            //     color: Colors.white,
                            //   ),
                            //   onTap: () {
                            //     Navigator.pop(context);
                            //     widget.changeItem(4);
                            //   },
                            // ),
                            // Divider(
                            //   indent: 20,
                            //   endIndent: 20,
                            //   color: Colors.grey,
                            // ),
                            // ListTile(
                            //   title: Text(
                            //     'Community Calendar',
                            //     style: TextStyle(color: Colors.white, fontSize: 20),
                            //   ),
                            //   trailing: Icon(
                            //     Icons.arrow_forward_ios_rounded,
                            //     size: 20,
                            //     color: Colors.white,
                            //   ),
                            //   onTap: () {
                            //     Navigator.pop(context);
                            //     widget.changeItem(5);
                            //   },
                            // ),
                            // Divider(
                            //   indent: 20,
                            //   endIndent: 20,
                            //   color: Colors.grey,
                            // ),
                            // ListTile(
                            //   title: Text(
                            //     'Maintenance',
                            //     style: TextStyle(color: Colors.white, fontSize: 20),
                            //   ),
                            //   trailing: Icon(
                            //     Icons.arrow_forward_ios_rounded,
                            //     size: 20,
                            //     color: Colors.white,
                            //   ),
                            //   onTap: () {
                            //     Navigator.pop(context);
                            //     widget.changeItem(7);
                            //   },
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  logoutWidget(context)
                ],
              ),
            ),
          ));
    });
  }

  Widget logoutWidget(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await logoutUser(context);
      },
      child: Container(
        height: 71,
        color: Color(0xff000000).withOpacity(.3),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 20,
            ),
            Text(
              "Sign Out",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
            Spacer(),
            SvgPicture.asset(
              'assets/bottom_nav/arrow.svg',
              semanticsLabel: 'Close',
              width: 18,
              height: 13,
            ),
            SizedBox(
              width: 16,
            ),
          ],
        ),
      ),
    );
  }

  logoutUser(BuildContext context) async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    sharedPref.remove('user');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }
}
