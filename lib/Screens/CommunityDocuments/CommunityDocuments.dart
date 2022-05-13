import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';
import 'package:provider/provider.dart';
import 'package:venetian_pines/Models/document_model.dart';
import 'package:venetian_pines/Providers/document_provider.dart';
import 'package:venetian_pines/Screens/CommunityDocuments/OpenDoc.dart';

class CommunityDocuments extends StatefulWidget {
  @override
  _CommunityDocumentsState createState() => _CommunityDocumentsState();
}

class _CommunityDocumentsState extends State<CommunityDocuments> {
  double w, h;
  DocumentProvider documentProvider;
  List<DocumentModel> docuemnts = [];
  bool loading = true;

  init() async {
    documentProvider = Provider.of<DocumentProvider>(context, listen: false);
    await documentProvider.getAllDocs();
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cp = context.watch<DocumentProvider>();
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text(
          'Community Documents',
          style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Color.fromRGBO(1, 68, 58, 1),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: !loading ? docs(cp.documents) : progress(),
    );
  }

  Widget docs(List<DocumentModel> docs) {
    return ListView.builder(
        itemCount: docs.length,
        itemBuilder: (context, index) {
          return itemView(docs[index]);
        });
  }

  Widget itemView(DocumentModel doc) {
    return Column(
      children: [
        InkWell(
          onTap: () async {
            docClick(doc.link, doc.title);
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(42),
                    child: Image.network(
                      doc.cover,
                      height: 50,
                      width: 50,
                      fit: BoxFit.fill,
                    )),
                SizedBox(
                  width: 10,
                ),
                Text(
                  doc.title,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                Spacer(),
                Text(
                  Jiffy(doc.dateCreated).yMMMMd,
                  style: TextStyle(fontSize: 13),
                ),
                SizedBox(
                  width: 10,
                )
              ],
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 1,
          color: Colors.grey[300],
        )
      ],
    );
  }

  void docClick(String link, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => DocumentDetail(
                url: link,
                title: title,
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
