import 'package:flutter/material.dart';
import 'package:myapp/models/vehicle.dart';
import 'package:myapp/screens/admin/add_edit_vehicle_screen.dart';
import 'package:myapp/services/auth_service.dart';
import 'package:myapp/services/vehicle_service.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    final vehicleService = VehicleService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authService.signOut();
            },
          )
        ],
      ),
      body: StreamProvider<List<Vehicle>>.value(
        value: vehicleService.getVehicles(),
        initialData: const [],
        child: const VehicleList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddEditVehicleScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class VehicleList extends StatelessWidget {
  const VehicleList({super.key});

  @override
  Widget build(BuildContext context) {
    final vehicles = Provider.of<List<Vehicle>>(context);
    final vehicleService = VehicleService();

    return ListView.builder(
      itemCount: vehicles.length,
      itemBuilder: (context, index) {
        final vehicle = vehicles[index];
        return ListTile(
          title: Text(vehicle.name),
          subtitle: Text(vehicle.type),
          trailing: Text(vehicle.status),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddEditVehicleScreen(vehicle: vehicle),
              ),
            );
          },
          onLongPress: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Delete Vehicle'),
                content: const Text('Are you sure you want to delete this vehicle?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      vehicleService.deleteVehicle(vehicle.id!);
                      Navigator.of(context).pop();
                    },
                    child: const Text('Delete'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
