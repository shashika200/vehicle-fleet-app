import 'package:cloud_firestore/cloud_firestore.dart';

class Vehicle {
  final String? id;
  final String name;
  final String type;
  final String status;
  final String location;
  final String? details;
  final DateTime lastUpdated;

  Vehicle({
    this.id,
    required this.name,
    required this.type,
    required this.status,
    required this.location,
    this.details,
    required this.lastUpdated,
  });

  factory Vehicle.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Vehicle(
      id: doc.id,
      name: data['name'] ?? '',
      type: data['type'] ?? '',
      status: data['status'] ?? 'available',
      location: data['location'] ?? '',
      details: data['details'],
      lastUpdated: (data['lastUpdated'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'type': type,
      'status': status,
      'location': location,
      if (details != null) 'details': details,
      'lastUpdated': Timestamp.now(),
    };
  }
}
