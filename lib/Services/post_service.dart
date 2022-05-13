import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:venetian_pines/Models/PostModel.dart';

class PostService {
  // get all bulletins
  Future<List<PostModel>> getAllPosts(String type) async {
    print("getting all posts for $type");
    List<PostModel> bulletins = [];
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("Posts")
          .where('type', isEqualTo: type)
          .get();
      for (DocumentSnapshot ds in querySnapshot.docs) {
        bulletins.add(PostModel.fromJson(ds.data() as Map));
      }
      return bulletins;
    } catch (e) {
      print("Error getting all bulletins $e");
      return bulletins;
    }
  }
}
