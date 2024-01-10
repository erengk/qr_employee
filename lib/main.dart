import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:qr_employee/screens/login_screen.dart';
import 'package:qr_employee/services/shared_pref.dart';
import 'package:qr_employee/utils/custom_colors.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _initializeDependencies();
  runApp(const MyApp());
}

Future<void> _initializeDependencies() async {
  await SharedPref.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mekatronik',
      theme: ThemeData(
        scaffoldBackgroundColor: CustomColors.appBarColor,
      ),
      home: const LoginScreen(),
    );
  }
}
