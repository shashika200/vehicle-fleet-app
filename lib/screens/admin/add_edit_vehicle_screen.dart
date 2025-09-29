import 'package:flutter/material.dart';
import 'package:myapp/models/vehicle.dart';
import 'package:myapp/services/vehicle_service.dart';

class AddEditVehicleScreen extends StatefulWidget {
  final Vehicle? vehicle;

  const AddEditVehicleScreen({super.key, this.vehicle});

  @override
  State<AddEditVehicleScreen> createState() => _AddEditVehicleScreenState();
}

class _AddEditVehicleScreenState extends State<AddEditVehicleScreen> {
  final _formKey = GlobalKey<FormState>();
  final _vehicleService = VehicleService();

  late String _name;
  late String _type;
  late String _location;
  late String? _details;

  @override
  void initState() {
    super.initState();
    _name = widget.vehicle?.name ?? '';
    _type = widget.vehicle?.type ?? '';
    _location = widget.vehicle?.location ?? '';
    _details = widget.vehicle?.details;
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final newVehicle = Vehicle(
        id: widget.vehicle?.id,
        name: _name,
        type: _type,
        status: widget.vehicle?.status ?? 'available', // Default status
        location: _location,
        details: _details,
        lastUpdated: DateTime.now(),
      );

      if (widget.vehicle == null) {
        _vehicleService.addVehicle(newVehicle).then((_) {
          Navigator.of(context).pop();
        });
      } else {
        _vehicleService.updateVehicle(newVehicle).then((_) {
          Navigator.of(context).pop();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.vehicle == null ? 'Add Vehicle' : 'Edit Vehicle'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _name,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) => value!.isEmpty ? 'Please enter a name' : null,
                onSaved: (value) => _name = value!,
              ),
              TextFormField(
                initialValue: _type,
                decoration: const InputDecoration(labelText: 'Type (e.g., Sedan, Truck)'),
                validator: (value) => value!.isEmpty ? 'Please enter a type' : null,
                onSaved: (value) => _type = value!,
              ),
              TextFormField(
                initialValue: _location,
                decoration: const InputDecoration(labelText: 'Location'),
                validator: (value) => value!.isEmpty ? 'Please enter a location' : null,
                onSaved: (value) => _location = value!,
              ),
              TextFormField(
                initialValue: _details,
                decoration: const InputDecoration(labelText: 'Details (optional)'),
                onSaved: (value) => _details = value,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
