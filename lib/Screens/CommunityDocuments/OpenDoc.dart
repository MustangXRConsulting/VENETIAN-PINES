import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';

class DocumentDetail extends StatefulWidget {
  final String url, title;
  DocumentDetail({this.url, this.title});
  @override
  _DocumentDetailState createState() => _DocumentDetailState();
}

class _DocumentDetailState extends State<DocumentDetail> {
  PDFDocument doc;
  bool _isLoading = true;
  init() async {
    doc = await PDFDocument.fromURL(widget.url);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white,fontSize: 16),
        ),
        backgroundColor: Color.fromRGBO(1, 68, 58, 1),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
          child: _isLoading
              ? Container(color: Colors.white, child: Center(child: progress()))
              : PDFViewer(
                  document: doc,
                  indicatorBackground: Colors.green,
                  pickerButtonColor: Color(
                    0xff01443A,
                  ),
                )),
    );
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
