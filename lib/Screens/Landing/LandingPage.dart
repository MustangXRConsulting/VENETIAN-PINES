import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:jiffy/jiffy.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:venetian_pines/Models/PostModel.dart';
import 'package:venetian_pines/Screens/ChatPage/Chat.dart';

class LandingPage extends StatefulWidget {
  PostModel post;
  String type;
  double w;

  LandingPage({this.post, this.type, this.w});

  @override
  _LandingPageState createState() => _LandingPageState(post: post);
}

class _LandingPageState extends State<LandingPage> {
  PostModel post;

  _LandingPageState({this.post});

  bool loading = true;

  Future<Uint8List> resizeNative(String img, {double w, double h}) async {
    // get file
    http.Response response = await http.get(Uri.parse(img));
    Uint8List list = response.bodyBytes;
    final tempDir = await getTemporaryDirectory();
    final file = await new File('${tempDir.path}/temp.jpg').create();
    file.writeAsBytesSync(list);
    // resize
    File compressedFile = await FlutterNativeImage.compressImage(file.path,
        quality: 100, targetWidth: w.toInt(), targetHeight: h.toInt());
    return compressedFile.readAsBytesSync();
  }

  Future<Uint8List> resizeImage(String img, {double w, double h}) async {
    http.Response response = await http.get(Uri.parse(img));
    Uint8List list = response.bodyBytes;
    var result = await FlutterImageCompress.compressWithList(
      list,
      minHeight: w != null ? w.toInt() : 150,
      minWidth: h != null ? h.toInt() : 315,
      quality: 96,
      rotate: 0,
    );
    return result;
  }

  resize() async {
    widget.post.memoryImage =
        await resizeImage(widget.post.image, w: widget.w * .9, h: 180);
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
                mapTypeToTitle(),
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Spacer(),
              // GestureDetector(
              //   onTap: () {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => ChatScreen(
              //                   peerId: 'admin@admin.com',
              //                   peerAvatar: '',
              //                   peerName: 'admin',
              //                   mode: 1,
              //                 )));
              //   },
              //   child: Image.asset(
              //     'assets/icons/chat.png',
              //     width: 30,
              //     height: 30,
              //   ),
              // )
            ],
          ),
        ),
        body: Column(children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
              ),
              !loading
              ? Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      alignment: Alignment.topLeft,
                      child: Text(
                        post.title,
                        style: TextStyle(
                            color: Color(0xff2D2D2D),
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Stack(
                      children: [
                        Image.memory(
                          post.memoryImage,
                          height: 180,
                          fit: BoxFit.cover,
                          width: w * 0.9,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/bottom_nav/calendar.svg',
                            width: 15,
                            height: 15,
                            semanticsLabel: 'Close',
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(Jiffy(post.createdOn).yMMMMd)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Icon(
                            Icons.timer,
                            size: 16,
                            color: Color(0xff585858),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            post.time,
                            style: TextStyle(
                                color: Color(0xff585858), fontSize: 18),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        post.description,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                )
              : progress()
                ],
              ),
            ),
          ),
          if (widget.post.type == "4")
                      GestureDetector(
                        onTap: () async {
                          if (await canLaunch(widget.post.url))
                            launch(widget.post.url);
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          padding: EdgeInsets.all(8),
                          width: w * 0.84,
                          decoration: BoxDecoration(
                            color: Color(0x30447727),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Text(
                              'View More',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff447727)),
                            ),
                          ),
                        ),
                      )
        ],),);
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

    return "";
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
}
