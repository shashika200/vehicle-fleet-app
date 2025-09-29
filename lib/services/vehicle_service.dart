import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/vehicle.dart';

class VehicleService extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final CollectionReference _vehiclesCollection;

  VehicleService() {
    _vehiclesCollection = _firestore.collection('vehicles');
  }

  // Create
  Future<void> addVehicle(Vehicle vehicle) async {
    await _vehiclesCollection.add(vehicle.toMap());
    notifyListeners();
  }

  // Read
  Stream<List<Vehicle>> getVehiclesStream() {
    return _vehiclesCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Vehicle.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }

  // Update
  Future<void> updateVehicle(Vehicle vehicle) async {
    await _vehiclesCollection.doc(vehicle.id).update(vehicle.toMap());
    notifyListeners();
  }

  // Delete
  Future<void> deleteVehicle(String vehicleId) async {
    await _vehiclesCollection.doc(vehicleId).delete();
    notifyListeners();
  }
}
