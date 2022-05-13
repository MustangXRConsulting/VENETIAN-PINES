import 'package:flutter/material.dart';
import 'package:venetian_pines/Models/maintenance_model.dart';
import 'package:venetian_pines/Services/maintenance_service.dart';

class MaintenanceProvider extends ChangeNotifier {
  MaintenanceService maintenanceService = new MaintenanceService();
  List<MaintenanceModel> maintenances = [];
  // create maintenace request
  Future<bool> createMaintenance(MaintenanceModel maintenanceModel) async {
    return await maintenanceService.createMaintenanceRequest(maintenanceModel);
  }

  // create amenity request
  Future<bool> createAmenity(Map<String, dynamic> data) async {
    return await maintenanceService.createAmenity(data);
  }

  // get all requests
  Future<List<MaintenanceModel>> getAllRequests(String email) async {
    maintenances = await maintenanceService.getAllRequests(email);
    maintenances.sort((a, b) => a.lastUpdated.compareTo(b.lastUpdated));
    maintenances = maintenances.reversed.toList();
    notifyListeners();
  }
}
