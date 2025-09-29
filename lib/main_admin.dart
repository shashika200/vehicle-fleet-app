import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myapp/firebase_options.dart';
import 'package:myapp/screens/admin/admin_wrapper.dart';
import 'package:myapp/services/auth_service.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const AdminApp());
}

class AdminApp extends StatelessWidget {
  const AdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(),
        ),
        StreamProvider<User?>.value(
          value: AuthService().user,
          initialData: FirebaseAuth.instance.currentUser,
        )
      ],
      child: MaterialApp(
        title: 'Vehicle Admin',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: const AdminWrapper(),
      ),
    );
  }
}
