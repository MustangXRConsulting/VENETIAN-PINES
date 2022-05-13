import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:venetian_pines/Models/document_model.dart';

class DocumentService {
  //get all docs
  Future<List<DocumentModel>> getAllDocuments() async {
    List<DocumentModel> docs = [];
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection("CommunityDocs").get();
      for (DocumentSnapshot ds in querySnapshot.docs) {
        docs.add(DocumentModel.fromJson(ds.data() as Map));
      }
      return docs;
    } catch (e) {
      print("Error getting all documents $e");
      return docs;
    }
  }
}
