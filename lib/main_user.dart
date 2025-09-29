import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myapp/firebase_options.dart';
import 'package:myapp/screens/user/home_screen.dart';
import 'package:myapp/services/vehicle_service.dart';
import 'package:provider/provider.dart';
import 'package:myapp/models/vehicle.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const UserApp());
}

class UserApp extends StatelessWidget {
  const UserApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Vehicle>>.value(
      value: VehicleService().getVehicles(),
      initialData: const [],
      child: MaterialApp(
        title: 'Vehicle Locator',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
