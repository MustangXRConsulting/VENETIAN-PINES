import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_scroll_to_top/flutter_scroll_to_top.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jiffy/jiffy.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';
import 'package:provider/provider.dart';
import 'package:venetian_pines/Models/PostModel.dart';
import 'package:venetian_pines/Providers/post_provider.dart';
import 'package:venetian_pines/Screens/Home/side_nav.dart';
import 'package:venetian_pines/Screens/Landing/LandingPage.dart';
import 'package:venetian_pines/Screens/PostPage/widget/calendar_view.dart';
import 'package:venetian_pines/Screens/Widget/FeedWdiget.dart';
import 'package:venetian_pines/Screens/Widget/filter.dart';

class PostPage extends StatefulWidget {
  String type;
  BuildContext context;
  Function onItemTap;
  PostPage({this.type, this.context,this.onItemTap});
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  double w, h;
  PostProivder postProivder;
  List<PostModel> posts = [];
  bool loading = true;
  bool search = false;
  bool calView = false;
  ScrollController scrollController = new ScrollController();
  init() async {
    postProivder = Provider.of<PostProivder>(context, listen: false);
    postProivder.setType(widget.type);
    await postProivder.getAllPosts(widget.type == '1');
    setState(() {
      loading = false;
    });
  }

  final scaffoldKey=GlobalKey<ScaffoldState>();

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    final cp = context.watch<PostProivder>();

    return Scaffold(
      key: scaffoldKey,
      drawer: DrawerNav(
        changeItem: widget.onItemTap,
      ),
      // extendBodyBehindAppBar: true,
      // extendBody: true,
      appBar: AppBar(
        leading: Container(
          margin: EdgeInsets.only(left: 10),
          child: IconButton(
            icon: Icon(
                widget.type == '1' ||
                        widget.type == '4' ||
                        widget.type == '3' ||
                        widget.type == '5'
                    ? Icons.menu
                    : Icons.arrow_back_rounded,
                color: Colors.white), // set your color here
            onPressed: () {
              if (widget.type == '1' ||
                  widget.type == '4' ||
                  widget.type == '3' ||
                  widget.type == '5') {
                scaffoldKey.currentState.openDrawer();
              } else {
                Navigator.of(context, rootNavigator: true).pop();
              }
            },
          ),
        ),
        backgroundColor: Color.fromRGBO(1, 68, 58, 1),
        title: Row(
          children: [
            !search
                ? Text(
                    mapTypeToTitle(),
                    style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                  )
                : Container(width: w * .6, child: searchBox()),
            Spacer(),
            if (widget.type != '3' && widget.type != '4' && widget.type != '5')
              GestureDetector(
                onTap: () {
                  setState(() {
                    search = !search;
                  });
                },
                child: Padding(
                  padding: !search
                      ? const EdgeInsets.all(8.0)
                      : const EdgeInsets.only(top: 8, bottom: 8, right: 20),
                  child: Icon(
                    !search ? Icons.search : Icons.cancel_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
      ),
      body: Container(
        width: w,
        height: h,
        child: Column(
          children: [
            // Container(
            //     width: w,
            //     height: h * .25,
            //     // color: Colors.red,
            //     child: Stack(
            //       children: [
            //         Image.asset(
            //           'assets/background.png',
            //           width: w,
            //           fit: BoxFit.fitWidth,
            //         ),
            //         Image.asset(
            //           'assets/greengrad.png',
            //           width: w,
            //           fit: BoxFit.fitWidth,
            //         ),
            //         Positioned(
            //           top: h * .15,
            //           left: 20,
            //           right: 20,
            //           child: Filters(),
            //         ),
            //         Positioned(
            //           top: h * .05,
            //           left: 5,
            //           child: Container(
            //             width: w,
            //             child: Row(
            //               mainAxisSize: MainAxisSize.max,
            //               children: [
            //                 IconButton(
            //                   icon: Icon(
            //                       widget.type == '1' ||
            //                               widget.type == '4' ||
            //                               widget.type == '3' ||
            //                               widget.type == '5' ||
            //                               widget.type == '6'
            //                           ? Icons.menu
            //                           : Icons.arrow_back_rounded,
            //                       color: Colors.white), // set your color here
            //                   onPressed: () {
            //                     if (widget.type == '1' ||
            //                         widget.type == '4' ||
            //                         widget.type == '3' ||
            //                         widget.type == '5' ||
            //                         widget.type == '6') {
            //                       Scaffold.of(widget.context != null
            //                               ? widget.context
            //                               : context)
            //                           .openDrawer();
            //                     } else {
            //                       Navigator.of(context, rootNavigator: true)
            //                           .pop();
            //                     }
            //                   },
            //                 ),
            //                 SizedBox(
            //                   width: 10,
            //                 ),
            //                 !search
            //                     ? Text(
            //                         mapTypeToTitle(),
            //                         style: TextStyle(
            //                             fontSize: 20,
            //                             color: Colors.white,
            //                             fontWeight: FontWeight.w700),
            //                       )
            //                     : Container(width: w * .65, child: searchBox()),
            //                 Spacer(),
            //                 if (widget.type != '3' &&
            //                     widget.type != '4' &&
            //                     widget.type != '5')
            //                   GestureDetector(
            //                     onTap: () {
            //                       setState(() {
            //                         search = !search;
            //                       });
            //                     },
            //                     child: Padding(
            //                       padding: !search
            //                           ? const EdgeInsets.all(8.0)
            //                           : const EdgeInsets.only(
            //                               top: 8, bottom: 8, right: 20),
            //                       child: Icon(
            //                         !search
            //                             ? Icons.search
            //                             : Icons.cancel_outlined,
            //                         color: Colors.white,
            //                       ),
            //                     ),
            //                   ),
            //                 SizedBox(
            //                   width: 10,
            //                 )
            //               ],
            //             ),
            //           ),
            //         )
            //       ],
            //     )),
            if (widget.type != '3' && widget.type != '4' && widget.type != '5')
              Container(
                margin: EdgeInsets.only(top: 24, left: 20, right: 20),
                child: Filters(
                  darkMode: true,
                ),
              ),

            if (widget.type != '3' && widget.type != '4' && widget.type != '5')
              VeiwCal(),
            SizedBox(
              height: 20,
            ),
            !calView
                ? Expanded(
                    child: !loading
                        ? Container(
                            alignment: Alignment.topLeft,
                            child: postList(cp.posts))
                        : progress())
                : Expanded(
                    child: CalendarView(
                    posts: cp.posts,
                  )),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  String mapTypeToTitle() {
    if (widget.type == '1') {
      return 'Community News';
    } else if (widget.type == '2') {
      return 'Community Updates';
    } else if (widget.type == '3') {
      return 'Homeowner Services';
    } else if (widget.type == '4') {
      return 'Marketplace';
    } else if (widget.type == '5') {
      return 'Reserve Amenities';
    } else if (widget.type == '6') {
      return 'Community Calendar';
    }
  }

  Widget progress() {
    return Center(
      child: NutsActivityIndicator(
          radius: 15,
          activeColor: Color(0xff447727).withOpacity(.6),
          inactiveColor: Color(0xff447727).withOpacity(.2),
          tickCount: 11,
          startRatio: 0.55,
          animationDuration: Duration(milliseconds: 500)),
    );
  }

  Widget postList(List<PostModel> posts) {
    return posts.length > 0
        ? Container(
            child: ScrollWrapper(
              scrollController: scrollController,
              promptAlignment: Alignment.bottomRight,
              scrollToTopDuration: Duration(microseconds: 500),
              promptReplacementBuilder:
                  (BuildContext context, Function scrollToTop) {
                return MaterialButton(
                  onPressed: () {
                    scrollToTop();
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xff01443A),
                    ),
                    child: Icon(
                      Icons.keyboard_arrow_up_rounded,
                      color: Colors.white,
                    ),
                  ),
                );
              },
              child: ListView.builder(
                  controller: scrollController,
                  padding: EdgeInsets.all(0.0),
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    return widget.type == '1'
                        ? postItem(posts[index])
                        : FeedWdiget(
                            post: posts[index],
                          );
                  }),
            ),
          )
        : Center(
            child: Text("Nothing to show!"),
          );
  }

  Widget postItem(PostModel post) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LandingPage(
                    post: post,
                    type: post.type,
                    w: w,
                  )),
        );
      },
      child: Container(
        height: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            border: Border.all(
                color: Color(0xff01443A).withOpacity(.34), width: 2)),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Image.memory(
                post.memoryImage,
                height: 150,
                width: 125,
                fit: BoxFit.fill,
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                margin: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(),
                    Text(
                      '${post.title}',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                    Spacer(),
                    Container(
                      height: h * 0.05,
                      width: w * 0.34,
                      decoration: BoxDecoration(
                        color: Color(0x30447727),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          post.type == '5' ? 'Reserve Now' : 'View More',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff447727)),
                        ),
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/bottom_nav/calendar.svg',
                          width: 16,
                          height: 16,
                          color: Color(0xff585858),
                          semanticsLabel: 'A red up arrow',
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          Jiffy(post.createdOn).yMMMMd,
                          style:
                              TextStyle(color: Color(0xff585858), fontSize: 18),
                        )
                      ],
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
            Container(
                height: double.infinity,
                width: 2,
                color: Color(0xff01443A).withOpacity(.34)),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Icon(Icons.arrow_forward_ios)],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget searchBox() {
    OutlineInputBorder focusBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      borderSide: BorderSide(width: 1, color: Colors.black),
    );
    return Container(
      height: 35,
      decoration: new BoxDecoration(
        shape: BoxShape.rectangle,
        color: Color(0xff01443A),
        borderRadius: BorderRadius.all(Radius.circular(5)),
        border: new Border.all(
          color: Colors.grey,
          width: 1.0,
        ),
      ),
      child: TextField(
        style: TextStyle(color: Colors.white, fontSize: 16),
        onChanged: (val) {
          postProivder.filterByQuery(val);
        },
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10.0),
          focusedBorder: focusBorder,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          //filled: true,
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
          //fillColor: Colors.white
        ),
      ),
    );
  }

  Widget VeiwCal() {
    return GestureDetector(
      onTap: () {
        setState(() {
          calView = !calView;
        });
      },
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 20),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Color(0xff447727).withOpacity(.07),
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/bottom_nav/calendar.svg',
              width: 20,
              height: 20,
              color: Color(0xff447727),
              semanticsLabel: 'A red up arrow',
            ),
            SizedBox(
              width: 6,
            ),
            Text(
              !calView ? "VIEW CALENDAR" : "VIEW LIST",
              style: TextStyle(color: Color(0xff447727), fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
