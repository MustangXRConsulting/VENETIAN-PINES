import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:venetian_pines/Models/maintenance_model.dart';

class MaintenanceService {
  // save request
  Future<bool> createMaintenanceRequest(
      MaintenanceModel maintenanceModel) async {
    try {
      await FirebaseFirestore.instance
          .collection('MaintenanceRequests')
          .add(maintenanceModel.toJson());
      return true;
    } catch (e) {
      print("failed to create maintenance request");
      return false;
    }
  }

  // save amentiy
  Future<bool> createAmenity(Map<String, dynamic> data) async {
    try {
      await FirebaseFirestore.instance.collection('Amenities').add(data);
      return true;
    } catch (e) {
      print("failed to create amenity request");
      return false;
    }
  }

  // get my requrests
  Future<List<MaintenanceModel>> getAllRequests(String email) async {
    List<MaintenanceModel> mains = [];
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('MaintenanceRequests')
          .where('email', isEqualTo: email)
          .get();
      if (snapshot.docs.length > 0) {
        for (DocumentSnapshot ds in snapshot.docs) {
          mains.add(new MaintenanceModel.fromJson(ds.data() as Map));
        }
      }
      return mains;
    } catch (e) {
      print("Error getting maintenance reqeusts $e");
      return mains;
    }
  }
}
