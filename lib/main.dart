import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:qr_employee/screens/login_screen.dart';
import 'package:qr_employee/utils/custom_colors.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'mekatronik',
      theme: ThemeData(
        scaffoldBackgroundColor: CustomColors.appBarColor,
      ),
      home: const LoginScreen(),
    );
  }
}
