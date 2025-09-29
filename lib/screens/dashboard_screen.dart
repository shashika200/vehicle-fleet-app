import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/vehicle.dart';
import '../services/vehicle_service.dart';
import '../widgets/filter_bar.dart';
import '../widgets/vehicle_list.dart';
import 'add_edit_vehicle_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String _statusFilter = 'All';
  String _searchQuery = '';

  void _onFilterChanged(String status, String query) {
    setState(() {
      _statusFilter = status;
      _searchQuery = query.toLowerCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        centerTitle: true,
        elevation: 2,
      ),
      body: Column(
        children: [
          FilterBar(
            onFilterChanged: _onFilterChanged,
            statusFilter: _statusFilter,
            searchQuery: _searchQuery,
          ),
          Expanded(
            child: StreamBuilder<List<Vehicle>>(
              stream: context.read<VehicleService>().getVehiclesStream(),
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
                    'No vehicles found.',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ));
                }

                // Apply filtering and searching locally
                List<Vehicle> filteredList = snapshot.data!;

                if (_statusFilter != 'All') {
                  filteredList = filteredList
                      .where((v) => v.status == _statusFilter)
                      .toList();
                }

                if (_searchQuery.isNotEmpty) {
                  filteredList = filteredList.where((v) {
                    return v.name.toLowerCase().contains(_searchQuery) ||
                           v.vehicleNumber.toLowerCase().contains(_searchQuery) ||
                           v.location.toLowerCase().contains(_searchQuery);
                  }).toList();
                }

                return VehicleList(vehicles: filteredList);
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
              fullscreenDialog: true,
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Vehicle'),
        tooltip: 'Add a new vehicle',
      ),
    );
  }
}
