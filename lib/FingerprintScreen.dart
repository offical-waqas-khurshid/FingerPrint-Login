import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'FingerprintController.dart';

class BiometricScreen extends StatelessWidget {
  final FingerPrintController _biometricController =
  Get.put(FingerPrintController());

  BiometricScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await _biometricController.checkBiometrics();
            if (_biometricController.isAuthenticated.value) {
              // Biometric authentication successful, proceed with your app logic
            } else {
              // Biometric authentication failed or was canceled
              await _biometricController.authenticate();
            }
          },
          child: Text('Authenticate with Biometrics'),
        ),
      ),
    );
  }
}