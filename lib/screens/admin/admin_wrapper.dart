import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/screens/admin/dashboard_screen.dart';
import 'package:myapp/screens/admin/login_screen.dart';
import 'package:provider/provider.dart';

class AdminWrapper extends StatelessWidget {
  const AdminWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    // return either the Dashboard or Login screen
    if (user == null) {
      return const LoginScreen();
    } else {
      return const DashboardScreen();
    }
  }
}
