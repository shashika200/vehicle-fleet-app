import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/vehicle.dart';
import '../services/vehicle_service.dart';
import '../widgets/vehicle_list.dart';
import '../widgets/filter_bar.dart';
import 'add_edit_vehicle_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late Stream<List<Vehicle>> _vehicleStream;
  String _statusFilter = 'All';
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    // Listen to the stream from the service
    _vehicleStream = context.read<VehicleService>().getVehiclesStream();
  }

  void _updateFilters(String status, String query) {
    setState(() {
      _statusFilter = status;
      _searchQuery = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        elevation: 4,
      ),
      body: Column(
        children: [
          FilterBar(
            onFilterChanged: _updateFilters,
            statusFilter: _statusFilter,
            searchQuery: _searchQuery,
          ),
          Expanded(
            child: StreamBuilder<List<Vehicle>>(
              stream: _vehicleStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text(
                      'No vehicles found. Tap the + button to add one.',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                // Apply filtering logic here
                List<Vehicle> filteredVehicles = snapshot.data!;

                if (_statusFilter != 'All') {
                  filteredVehicles = filteredVehicles
                      .where((v) => v.status == _statusFilter)
                      .toList();
                }

                if (_searchQuery.isNotEmpty) {
                  filteredVehicles = filteredVehicles
                      .where((v) =>
                          v.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                          v.vehicleNumber.toLowerCase().contains(_searchQuery.toLowerCase()) || // Search by vehicle number
                          v.location.toLowerCase().contains(_searchQuery.toLowerCase()))
                      .toList();
                }

                return VehicleList(vehicles: filteredVehicles);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddEditVehicleScreen(),
            ),
          );
        },
        label: const Text('Add Vehicle'),
        icon: const Icon(Icons.add),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        foregroundColor: Theme.of(context).colorScheme.onSecondary,
      ),
    );
  }
}
