import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/vehicle.dart';
import '../services/vehicle_service.dart';
import 'vehicle_detail_screen.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  String _searchQuery = '';
  String _selectedStatus = 'All';

  final List<String> _vehicleStatuses = ['All', 'Available', 'Under Repair', 'Unavailable'];

  @override
  Widget build(BuildContext context) {
    final vehicleService = Provider.of<VehicleService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicle Management'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search by name, number, or location',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) => setState(() => _searchQuery = value),
            ),
          ),
          Wrap(
            spacing: 8.0,
            children: _vehicleStatuses.map((status) {
              return FilterChip(
                label: Text(status),
                selected: _selectedStatus == status,
                onSelected: (isSelected) {
                  if (isSelected) {
                    setState(() => _selectedStatus = status);
                  }
                },
              );
            }).toList(),
          ),
          Expanded(
            child: StreamBuilder<List<Vehicle>>(
              stream: vehicleService.getVehiclesStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No vehicles found.'));
                }

                final filteredVehicles = snapshot.data!.where((v) {
                  final matchesSearch = _searchQuery.isEmpty ||
                      v.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                      v.vehicleNumber.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                      v.location.toLowerCase().contains(_searchQuery.toLowerCase());
                  final matchesStatus = _selectedStatus == 'All' || v.status == _selectedStatus;
                  return matchesSearch && matchesStatus;
                }).toList();

                return ListView.builder(
                  itemCount: filteredVehicles.length,
                  itemBuilder: (context, index) {
                    final vehicle = filteredVehicles[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ListTile(
                        title: Text(vehicle.name),
                        subtitle: Text('${vehicle.vehicleNumber} - ${vehicle.location}'),
                        trailing: Text(vehicle.status, style: TextStyle(color: _getStatusColor(vehicle.status))),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => VehicleDetailScreen(vehicle: vehicle),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  
    Color _getStatusColor(String status) {
    switch (status) {
      case 'Available':
        return Colors.green;
      case 'Under Repair':
        return Colors.orange;
      case 'Unavailable':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
