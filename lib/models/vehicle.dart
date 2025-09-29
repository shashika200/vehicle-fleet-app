import 'package:cloud_firestore/cloud_firestore.dart';

class Vehicle {
  final String id;
  final String name;
  final String vehicleNumber;
  final String type; // Added field
  final String status;
  final String location;
  final String? details;
  final Timestamp? lastUpdated; // Added field

  Vehicle({
    required this.id,
    required this.name,
    required this.vehicleNumber,
    required this.type,
    required this.status,
    required this.location,
    this.details,
    this.lastUpdated,
  });

  // Convert a Vehicle object into a map, including the server timestamp
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'vehicleNumber': vehicleNumber,
      'type': type,
      'status': status,
      'location': location,
      'details': details,
      'lastUpdated': FieldValue.serverTimestamp(), // Automatically set by Firestore
    };
  }

  // Create a Vehicle object from a map
  factory Vehicle.fromMap(Map<String, dynamic> map, String documentId) {
    return Vehicle(
      id: documentId,
      name: map['name'] ?? '',
      vehicleNumber: map['vehicleNumber'] ?? '',
      type: map['type'] ?? 'N/A', // Provide default value
      status: map['status'] ?? 'Unknown',
      location: map['location'] ?? 'Unknown',
      details: map['details'],
      lastUpdated: map['lastUpdated'] as Timestamp?,
    );
  }
}
