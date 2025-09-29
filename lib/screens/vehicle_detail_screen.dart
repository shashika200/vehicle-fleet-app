import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/vehicle.dart';

class VehicleDetailScreen extends StatelessWidget {
  final Vehicle vehicle;

  const VehicleDetailScreen({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(vehicle.name),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildDetailRow(context, 'Vehicle Number', vehicle.vehicleNumber),
            _buildDetailRow(context, 'Status', vehicle.status, statusColor: _getStatusColor(vehicle.status)),
            _buildDetailRow(context, 'Location', vehicle.location),
            if (vehicle.details != null && vehicle.details!.isNotEmpty)
              _buildDetailRow(context, 'Details', vehicle.details!),
            if (vehicle.lastUpdated != null)
              _buildDetailRow(context, 'Last Updated', DateFormat.yMMMd().add_jms().format(vehicle.lastUpdated!.toDate())),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value, {Color? statusColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(label, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: statusColor),
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
