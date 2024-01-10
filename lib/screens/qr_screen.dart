import 'package:flutter/material.dart';
import 'package:qr_employee/screens/login_screen.dart';
import 'package:qr_employee/services/auth_service.dart';
import 'package:qr_employee/services/shared_pref.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../utils/custom_colors.dart';

class QRScreen extends StatelessWidget {
  final String? uid;

  const QRScreen({super.key, this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () async {
            await AuthService.signOut();
            await SharedPref.clear();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
            );
          },
        ),
        title: const Text('QR Kodu'),
        backgroundColor: CustomColors.appBarColor,
      ),
      backgroundColor: CustomColors.textButtonColor,
      body: Center(
        child: QrImageView(
          data: uid!,
          version: QrVersions.auto,
          size: 200.0,
        ),
      ),
    );
  }
}
