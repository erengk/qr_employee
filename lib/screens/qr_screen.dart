import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../utils/custom_colors.dart';

class QRScreen extends StatelessWidget {
  final String uid;

  const QRScreen({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Kodu'),
        backgroundColor: CustomColors.appBarColor,
      ),
      backgroundColor: CustomColors.textButtonColor,
      body: Center(
        child: QrImageView(
          data: uid,
          version: QrVersions.auto,
          size: 200.0,
        ),
      ),
    );
  }
}
