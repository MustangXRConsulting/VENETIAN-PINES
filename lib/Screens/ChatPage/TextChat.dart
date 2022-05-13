import 'package:flutter/material.dart';

class TextChatPage extends StatefulWidget {
  var name, image, id;
  TextChatPage({@required this.name, @required this.image, @required this.id});

  @override
  _TextChatPageState createState() => _TextChatPageState();
}

class _TextChatPageState extends State<TextChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                // border: Border.all(
                //   color: Color(0xffe07add),
                //   width: 2,
                // ),
                borderRadius: BorderRadius.circular(85),
              ),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: widget.image.isEmpty
                      ? Image.asset(
                          "assets/default_user.png",
                          height: 37,
                          width: 37,
                          fit: BoxFit.fill,
                        )
                      : Image.network(
                          widget.image,
                          height: 37,
                          width: 37,
                          fit: BoxFit.fill,
                        ),
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  'Online',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                )
              ],
            )
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.more_vert_outlined,
              color: Colors.black,
            ),
          )
        ],
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.black,
            )),
      ),
      body: Column(
        children: [
          Spacer(),
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: Container(
              height: 80,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.camera_alt_outlined,
                    color: Color(0xffE07ADD),
                    size: 35,
                  ),
                  Container(
                    width: 210,
                    height: 40,
                    child: TextField(
                      textAlign: TextAlign.start,
                      decoration: new InputDecoration(
                        filled: true,
                        // prefixIcon: Icon(Icons.emoji_emotions,color: Color(0xffE07ADD)),
                        fillColor: Color(0x20E07ADD),
                        hintText: 'Type message...',

                        focusedBorder: OutlineInputBorder(
                          borderSide: new BorderSide(color: Color(0x20E07ADD)),
                          borderRadius: new BorderRadius.circular(25.7),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: new BorderSide(color: Color(0x20E07ADD)),
                          borderRadius: new BorderRadius.circular(25.7),
                        ),
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Color(0x20E07ADD),
                    child: Image.asset('assets/send.png',
                        height: 24, width: 24, color: Color(0xffE07ADD)),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
