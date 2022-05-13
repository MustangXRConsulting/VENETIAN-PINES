import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:venetian_pines/Screens/ChatPage/Chat.dart';
import 'package:venetian_pines/Screens/Home/side_nav.dart';
import 'package:venetian_pines/Screens/Maintenance/MaintenancePage.dart';
import 'package:venetian_pines/Screens/MyHOA/MyHOA.dart';
import 'package:venetian_pines/Screens/PostPage/PostPage.dart';
import 'package:venetian_pines/Screens/PostPage/widget/community_news.dart';

class MultiNavHome extends StatefulWidget {
  const MultiNavHome({Key key}) : super(key: key);

  @override
  _MultiNavHomeState createState() => _MultiNavHomeState();
}

class _MultiNavHomeState extends State<MultiNavHome>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  TabController _tabController;
  int selected = 0;
  Color selColor = Color.fromRGBO(1, 68, 58, 1);
  Color unSelColor = Color(0xffa0a0a0);

  void _onItemTapped(int index) {
    changeItem(index);
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 8);
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
      if (_selectedIndex == 0) {
        SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        print(_selectedIndex);
        if (_selectedIndex == 4) {
          changeItem(6);
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: DefaultTabController(
        length: 8,
        child: Builder(builder: (BuildContext context) {
          final TabController tabController = DefaultTabController.of(context);
          tabController.addListener(() {
            _onItemTapped(tabController.index);
          });
          return Scaffold(
            drawer: DrawerNav(changeItem: _onItemTapped, selected: selected),
            backgroundColor: Color(0xffFBFBFB),
            body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: [
                MyHOA(
                  changeItem: _onItemTapped,
                ),
                CommunityNews(
                  context: context,
                  type: '1',
                ),
                PostPage(
                  context: context,
                  onItemTap: _onItemTapped,
                  type: '4',
                ),
                MaintenancePage(),
                ChatScreen(
                  selectIndex: changeItem,
                  peerId: 'admin@admin.com',
                  peerAvatar: '',
                  peerName: 'admin',
                ),
                PostPage(
                  type: '3',
                  onItemTap: _onItemTapped,
                ),
                PostPage(
                  type: '5',
                  onItemTap: _onItemTapped
                ),
                PostPage(
                  type: '6',
                  onItemTap: _onItemTapped
                )
              ],
            ),
            bottomNavigationBar: bottomNavigation(_selectedIndex),
          );
        }),
      ),
    );
  }

  void changeItem(int val) {
    setState(() {
      selected = val;
    });
    if (selected == 0) {
      setState(() {
        _selectedIndex = 1;
        _tabController.index = 1;
      });
    } else if (selected == 2) {
      setState(() {
        _selectedIndex = 5;
        _tabController.index = 5;
      });
    } else if (selected == 3) {
      setState(() {
        _selectedIndex = 2;
        _tabController.index = 2;
      });
    } else if (selected == 4) {
      setState(() {
        _selectedIndex = 6;
        _tabController.index = 6;
      });
    } else if (selected == 5) {
      setState(() {
        _selectedIndex = 7;
        _tabController.index = 7;
      });
    } else if (selected == 7) {
      setState(() {
        _selectedIndex = 3;
        _tabController.index = 3;
      });
    } else if (selected == 6) {
      setState(() {
        _selectedIndex = 0;
        _tabController.index = 0;
      });
    } else if (selected == 8) {
      setState(() {
        _selectedIndex = 0;
        _tabController.index = 0;
      });
    }
    else if(selected==10){
      _selectedIndex=4;
      _tabController.index=4;
    }
  }

  Widget bottomNavigation(int selected) {
    return Container(
      height: Platform.isAndroid ? 70 : 90,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: Platform.isAndroid
            ? const EdgeInsets.all(0)
            : const EdgeInsets.only(bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            bottomNavItem(selected == 0, 'assets/bottom_nav/hoa.svg', 'My HOA',
                () {
              _onItemTapped(6);
            }),
            bottomNavItem(selected == 1, 'assets/bottom_nav/news.svg', 'News',
                () {
              _onItemTapped(0);
            }),
            bottomNavItem(
              selected == 2,
              'assets/icons/icon_cart_active.svg',
              'Marketplace',
              () {
                _onItemTapped(3);
              },
            ),
            bottomNavItem(selected == 3, 'assets/bottom_nav/maintenance.svg',
                'Maintenance', () {
              _onItemTapped(7);
            }),
            bottomNavItem(
                selected == 4, 'assets/bottom_nav/message.svg', 'Chat', () {
              _onItemTapped(10);
            }),
          ],
        ),
      ),
    );
  }

  Widget bottomNavItem(
      bool selected, String url, String title, Function callback,
      {double width, double height}) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        width: MediaQuery.of(context).size.width * .2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: callback,
              child: SvgPicture.asset(
                url,
                width: width != null ? width : 25,
                height: height != null ? height : 25,
                color: selected ? selColor : unSelColor,
                semanticsLabel: 'A red up arrow',
              ),
            ),
            GestureDetector(
              onTap: callback,
              child: Text(
                title,
                style: TextStyle(
                    color: selected ? selColor : unSelColor,
                    fontSize: 11,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
