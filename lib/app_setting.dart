import 'package:fingerprint_login/FingerprintController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
  final FingerPrintController fingerPrintController =
      Get.put(FingerPrintController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() {
              if (fingerPrintController.isFingerprintSupported.value) {
                return SwitchListTile(
                  title: const Text('Enable Fingerprint'),
                  value: fingerPrintController.isFingerprintEnabled.value,
                  onChanged: (value) {
                    if (value) {
                      /// Authenticate with fingerprint
                      fingerPrintController.authenticateWithFingerprint(() {
                        /// Handle authentication success and show password dialog
                        Get.defaultDialog(
                          title: 'Enter Password',
                          content: TextField(
                            controller: fingerPrintController.passwordController,
                            obscureText: true, // Hide password characters
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Password',
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: Get.back,
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: fingerPrintController.onPasswordSubmitted,
                              child: const Text('Submit'),
                            ),
                          ],
                        );
                      });
                    } else {
                      /// Disable fingerprint
                      fingerPrintController.isFingerprintEnabled.value = false;
                    }
                  },
                );
              } else {
                return const Text("Fingerprint not supported");
              }
            }),
          ],
        ),
      ),
    );
  }
}
