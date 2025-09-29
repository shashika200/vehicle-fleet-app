import 'package:cloud_firestore/cloud_firestore.dart';

class Vehicle {
  final String? id;
  final String name;
  final String vehicleNumber; // Changed from type
  final String status;
  final String location;
  final String? details;

  Vehicle({
    this.id,
    required this.name,
    required this.vehicleNumber, // Changed from type
    required this.status,
    required this.location,
    this.details,
  });

  // Factory to create a Vehicle from a Firestore document
  factory Vehicle.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Vehicle(
      id: doc.id,
      name: data['name'] ?? '',
      vehicleNumber: data['vehicleNumber'] ?? '', // Changed from type
      status: data['status'] ?? '',
      location: data['location'] ?? '',
      details: data['details'] as String?,
    );
  }

  // Method to convert a Vehicle to a map for Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'vehicleNumber': vehicleNumber, // Changed from type
      'status': status,
      'location': location,
      'details': details,
    };
  }

   // Method to create a copy with updated fields
  Vehicle copyWith({
    String? id,
    String? name,
    String? vehicleNumber,
    String? status,
    String? location,
    String? details,
  }) {
    return Vehicle(
      id: id ?? this.id,
      name: name ?? this.name,
      vehicleNumber: vehicleNumber ?? this.vehicleNumber, // Changed from type
      status: status ?? this.status,
      location: location ?? this.location,
      details: details ?? this.details,
    );
  }
}
