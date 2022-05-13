import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jiffy/jiffy.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:venetian_pines/Models/PostModel.dart';
import 'package:venetian_pines/Screens/Landing/LandingPage.dart';
import 'package:venetian_pines/Screens/ReserveAmenities/ReserveAmenities.dart';

// ignore: must_be_immutable
class FeedWdiget extends StatelessWidget {
  PostModel post;
  FeedWdiget({this.post});

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return IntrinsicHeight(
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 15),
        padding: EdgeInsets.all(10),
        //height: h * 0.4,
        width: w * 0.9,
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xffCECECE),
            width: .8,
          ),
          borderRadius: BorderRadius.circular(3),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(2.75),
              child: Image.memory(
                post.memoryImage,
                height: 180,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 8.0),
              alignment: Alignment.centerLeft,
              child: Text(
                '${post.title}',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ),
            if (post.type != '3' && post.type != '4' && post.type != '5')
              SizedBox(
                height: 8,
              ),
            if (post.type != '3' && post.type != '4' && post.type != '5')
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
                    style: TextStyle(color: Color(0xff585858), fontSize: 18),
                  )
                ],
              ),
            SizedBox(
              height: 8,
            ),
            if (post.type != '3' && post.type != '4' && post.type != '5')
            Row(
                children: [
                  Icon(
                    Icons.timer,
                    size:16,
                    color: Color(0xff585858),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    post.time,
                    style: TextStyle(color: Color(0xff585858), fontSize: 18),
                  )
                ],
              ),
              SizedBox(height: 8,),
            Text(
              post.description,
              maxLines: 4,
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 14,
            ),
            GestureDetector(
              onTap: () async {
                if (post.type == '5') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ReserveAmentities(
                              title: post.title,
                              description: post.description,
                              eventDate: post.createdOn,
                              img: post.image,
                              h: MediaQuery.of(context).size.height,
                              w: MediaQuery.of(context).size.width,
                            )),
                  );
                } else if (post.type == '4') {
                  // marketplace
                   Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LandingPage(
                              post: post,
                              type: post.type,
                              w: w,
                            )),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LandingPage(
                              post: post,
                              type: post.type,
                              w: w,
                            )),
                  );
                }
              },
              child: Container(
                padding: EdgeInsets.all(8),
                width: w * 0.84,
                decoration: BoxDecoration(
                  color: Color(0x30447727),
                  borderRadius: BorderRadius.circular(4),
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
            ),
          ],
        ),
      ),
    );
  }
}
