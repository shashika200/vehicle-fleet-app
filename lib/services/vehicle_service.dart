import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/vehicle.dart';

class VehicleService {
  final CollectionReference _vehiclesCollection = FirebaseFirestore.instance.collection('vehicles');

  // Method to get a stream of vehicles
  Stream<List<Vehicle>> getVehiclesStream() {
    return _vehiclesCollection.snapshots().map((snapshot) {
      try {
        return snapshot.docs.map((doc) => Vehicle.fromFirestore(doc)).toList();
      } catch (e) {
        // ignore: avoid_print
        print('Error parsing vehicle data: $e');
        return []; // Return an empty list on parsing error
      }
    });
  }

  // Method to add a new vehicle
  Future<void> addVehicle(Vehicle vehicle) {
    return _vehiclesCollection.add(vehicle.toFirestore());
  }

  // Method to update an existing vehicle
  Future<void> updateVehicle(Vehicle vehicle) {
    if (vehicle.id == null || vehicle.id!.isEmpty) {
        throw ArgumentError('Vehicle ID cannot be empty for an update.');
    }
    return _vehiclesCollection.doc(vehicle.id).update(vehicle.toFirestore());
  }

  // Method to delete a vehicle
  Future<void> deleteVehicle(String vehicleId) {
    return _vehiclesCollection.doc(vehicleId).delete();
  }
}
