import 'package:flutter/material.dart';
import 'package:venetian_pines/Screens/Home/side_nav.dart';
import 'package:venetian_pines/Screens/Maintenance/MaintenancePage.dart';
import 'package:venetian_pines/Screens/MyHOA/MyHOA.dart';
import 'package:venetian_pines/Screens/PostPage/PostPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget currentItem = Page(
      item: PostPage(
    type: '1',
  ));
  int selected = 0;

  void changeItem(int val) {
    print("val = $val");
    setState(() {
      selected = val;
    });
    if (selected == 0) {
      setState(() {
        currentItem = Page(
            key: GlobalKey(),
            item: PostPage(
              type: '1',
            ));
      });
    } else if (selected == 11) {
      setState(() {
        currentItem = Page(
            key: GlobalKey(),
            item: PostPage(
              type: '2',
            ));
      });
    } else if (selected == 2) {
      setState(() {
        currentItem = Page(
            key: GlobalKey(),
            item: PostPage(
              type: '3',
            ));
      });
    } else if (selected == 3) {
      setState(() {
        currentItem = Page(
            key: GlobalKey(),
            item: PostPage(
              type: '4',
            ));
      });
    } else if (selected == 4) {
      setState(() {
        currentItem = Page(
            key: GlobalKey(),
            item: PostPage(
              type: '5',
            ));
      });
    } else if (selected == 5) {
      setState(() {
        currentItem = Page(
            key: GlobalKey(),
            item: PostPage(
              type: '6',
            ));
      });
    } else if (selected == 7) {
      setState(() {
        currentItem = Page(key: GlobalKey(), item: MaintenancePage());
      });
    } else if (selected == 6) {
      setState(() {
        currentItem = Page(key: GlobalKey(), item: MyHOA(
          changeItem: changeItem,
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: currentItem,
      drawerEdgeDragWidth: MediaQuery.of(context).size.width,
      drawer: DrawerNav(
        changeItem: changeItem,
        selected: selected,
      ),
    );
  }
}

class Page extends StatelessWidget {
  final Widget item;
  const Page({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return item;
  }
}
