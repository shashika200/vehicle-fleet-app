import 'package:flutter/material.dart';
import 'package:myapp/models/vehicle.dart';
import 'package:myapp/screens/user/vehicle_detail_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final vehicles = Provider.of<List<Vehicle>>(context);
    final filteredVehicles = vehicles.where((v) {
      return v.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          v.type.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Vehicles'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Search by name or type',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredVehicles.length,
              itemBuilder: (context, index) {
                final vehicle = filteredVehicles[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: ListTile(
                    title: Text(vehicle.name),
                    subtitle: Text(vehicle.type),
                    trailing: Chip(
                      label: Text(
                        vehicle.status,
                        style: const TextStyle(color: Colors.white),
                      ),
                      backgroundColor: vehicle.status == 'available' ? Colors.green : Colors.orange,
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => VehicleDetailScreen(vehicle: vehicle),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
