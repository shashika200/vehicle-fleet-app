import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/vehicle.dart';
import '../services/vehicle_service.dart';

class AddEditVehicleScreen extends StatefulWidget {
  final Vehicle? vehicle;

  const AddEditVehicleScreen({super.key, this.vehicle});

  @override
  State<AddEditVehicleScreen> createState() => _AddEditVehicleScreenState();
}

class _AddEditVehicleScreenState extends State<AddEditVehicleScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _vehicleNumber; // Changed from _type
  late String _status;
  late String _location;
  String? _details;

  bool _isLoading = false;

  final List<String> _vehicleStatuses = ['Available', 'Under Repair', 'Unavailable'];

  @override
  void initState() {
    super.initState();
    _name = widget.vehicle?.name ?? '';
    _vehicleNumber = widget.vehicle?.vehicleNumber ?? ''; // Changed from _type
    _status = widget.vehicle?.status ?? _vehicleStatuses.first;
    _location = widget.vehicle?.location ?? '';
    _details = widget.vehicle?.details;
  }

  Future<void> _saveForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });

      final vehicleService = Provider.of<VehicleService>(context, listen: false);
      final messenger = ScaffoldMessenger.of(context);
      final navigator = Navigator.of(context);

      final vehicleToSave = Vehicle(
        id: widget.vehicle?.id ?? '',
        name: _name,
        vehicleNumber: _vehicleNumber, // Changed from type
        status: _status,
        location: _location,
        details: _details,
      );

      try {
        if (widget.vehicle == null) {
          await vehicleService.addVehicle(vehicleToSave);
          messenger.showSnackBar(const SnackBar(content: Text('Vehicle added successfully!')));
        } else {
          await vehicleService.updateVehicle(vehicleToSave);
          messenger.showSnackBar(const SnackBar(content: Text('Vehicle updated successfully!')));
        }
        navigator.pop();
      } catch (e) {
        messenger.showSnackBar(SnackBar(content: Text('Error saving vehicle: $e')));
      } finally {
         if (mounted) {
            setState(() {
                _isLoading = false;
            });
         }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.vehicle == null ? 'Add Vehicle' : 'Edit Vehicle'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _name,
                decoration: const InputDecoration(labelText: 'Name', border: OutlineInputBorder()),
                validator: (value) =>
                    value!.trim().isEmpty ? 'Please enter a name' : null,
                onSaved: (value) => _name = value!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: _vehicleNumber,
                decoration: const InputDecoration(labelText: 'Vehicle Number', border: OutlineInputBorder()),
                validator: (value) =>
                    value!.trim().isEmpty ? 'Please enter a vehicle number' : null,
                onSaved: (value) => _vehicleNumber = value!, 
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _status,
                decoration: const InputDecoration(labelText: 'Status', border: OutlineInputBorder()),
                items: _vehicleStatuses
                    .map((status) =>
                        DropdownMenuItem(value: status, child: Text(status)))
                    .toList(),
                onChanged: (value) => setState(() => _status = value!),
                validator: (value) => value == null ? 'Please select a status' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: _location,
                decoration: const InputDecoration(labelText: 'Location', border: OutlineInputBorder()),
                validator: (value) =>
                    value!.trim().isEmpty ? 'Please enter a location' : null,
                onSaved: (value) => _location = value!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: _details,
                decoration: const InputDecoration(labelText: 'Details (Optional)', border: OutlineInputBorder()),
                maxLines: 3,
                onSaved: (value) => _details = value,
              ),
              const SizedBox(height: 32),
              if (_isLoading)
                const Center(child: CircularProgressIndicator())
              else
                ElevatedButton(
                  onPressed: _saveForm,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(fontSize: 16)
                  ),
                  child: Text(widget.vehicle == null ? 'Add Vehicle' : 'Update Vehicle'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
