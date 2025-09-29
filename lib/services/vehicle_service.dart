import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/models/vehicle.dart';

class VehicleService {
  final CollectionReference _vehiclesCollection = FirebaseFirestore.instance.collection('vehicles');

  // Get a stream of vehicles
  Stream<List<Vehicle>> getVehicles() {
    return _vehiclesCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Vehicle.fromFirestore(doc)).toList();
    });
  }

  // Add a vehicle
  Future<void> addVehicle(Vehicle vehicle) {
    return _vehiclesCollection.add(vehicle.toFirestore());
  }

  // Update a vehicle
  Future<void> updateVehicle(Vehicle vehicle) {
    return _vehiclesCollection.doc(vehicle.id).update(vehicle.toFirestore());
  }

  // Delete a vehicle
  Future<void> deleteVehicle(String vehicleId) {
    return _vehiclesCollection.doc(vehicleId).delete();
  }
}
