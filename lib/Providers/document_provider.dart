import 'package:flutter/cupertino.dart';
import 'package:venetian_pines/Models/document_model.dart';
import 'package:venetian_pines/Services/document_service.dart';

class DocumentProvider extends ChangeNotifier {
  DocumentService documentService = new DocumentService();
  List<DocumentModel> documents = [];
  List<DocumentModel> orgDocs = [];

  // get all docs
  Future<List<DocumentModel>> getAllDocs() async {
    documents = await documentService.getAllDocuments();
    orgDocs = documents;
    notifyListeners();
  }
}
