
import 'package:cloud_firestore/cloud_firestore.dart';

class Vehicle {
  final String id;
  final String name;
  final String type;
  final String status;
  final String location;
  final String? details;

  Vehicle({
    required this.id,
    required this.name,
    required this.type,
    required this.status,
    required this.location,
    this.details,
  });

  // From Firestore document to Vehicle object
  factory Vehicle.fromMap(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Vehicle(
      id: doc.id,
      name: data['name'] ?? '',
      type: data['type'] ?? '',
      status: data['status'] ?? '',
      location: data['location'] ?? '',
      details: data['details'],
    );
  }

  // From Vehicle object to a Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'type': type,
      'status': status,
      'location': location,
      'details': details,
    };
  }
}
