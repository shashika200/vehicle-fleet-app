import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting if needed in future
import '../models/vehicle.dart';
import '../screens/add_edit_vehicle_screen.dart';
import '../services/vehicle_service.dart';
import 'package:provider/provider.dart';

class VehicleList extends StatelessWidget {
  final List<Vehicle> vehicles;

  const VehicleList({super.key, required this.vehicles});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      itemCount: vehicles.length,
      itemBuilder: (context, index) {
        final vehicle = vehicles[index];
        return Card(
          elevation: 3.0,
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            leading: _buildStatusIcon(vehicle.status),
            title: Text(
              vehicle.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  'Number: ${vehicle.vehicleNumber}',
                   style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
                ),
                const SizedBox(height: 2),
                Text(
                  'Location: ${vehicle.location}',
                  style: TextStyle(color: Colors.grey.shade600, fontStyle: FontStyle.italic),
                ),
                 if (vehicle.details != null && vehicle.details!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: Text(
                      'Details: ${vehicle.details}',
                       style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                    ),
                  ),
              ],
            ),
            trailing: _buildTrailingMenu(context, vehicle),
            onTap: () => _navigateToEditScreen(context, vehicle),
          ),
        );
      },
    );
  }

  Icon _buildStatusIcon(String status) {
    switch (status) {
      case 'Available':
        return const Icon(Icons.check_circle_outline, color: Colors.green, size: 40);
      case 'Under Repair':
        return const Icon(Icons.build_circle_outlined, color: Colors.orange, size: 40);
      case 'Unavailable':
        return const Icon(Icons.highlight_off_outlined, color: Colors.red, size: 40);
      default:
        return const Icon(Icons.help_outline, color: Colors.grey, size: 40);
    }
  }

  PopupMenuButton<String> _buildTrailingMenu(BuildContext context, Vehicle vehicle) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert),
      onSelected: (value) async {
        if (value == 'edit') {
          _navigateToEditScreen(context, vehicle);
        } else if (value == 'delete') {
          _confirmDelete(context, vehicle);
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'edit',
          child: ListTile(leading: Icon(Icons.edit), title: Text('Edit')),
        ),
        const PopupMenuItem<String>(
          value: 'delete',
          child: ListTile(leading: Icon(Icons.delete), title: Text('Delete')),
        ),
      ],
    );
  }


  void _navigateToEditScreen(BuildContext context, Vehicle vehicle) {
     Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddEditVehicleScreen(vehicle: vehicle),
            ),
          );
  }

  void _confirmDelete(BuildContext context, Vehicle vehicle) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirm Deletion'),
        content: Text('Are you sure you want to delete ${vehicle.name}?'),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(ctx).pop(),
          ),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
            onPressed: () async {
              try {
                await context.read<VehicleService>().deleteVehicle(vehicle.id!);
                Navigator.of(ctx).pop(); // Close the dialog
                 ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Vehicle deleted successfully'), backgroundColor: Colors.green),
                );
              } catch (e) {
                 Navigator.of(ctx).pop();
                 ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error deleting vehicle: $e'), backgroundColor: Colors.red),
                );
              }

            },
          ),
        ],
      ),
    );
  }
}
