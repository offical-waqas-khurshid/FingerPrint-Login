
import 'package:fingerprint_login/app_setting.dart';
import 'package:fingerprint_login/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'FingerprintController.dart';
import 'UserModel.dart';

class LoginScreen extends StatelessWidget {
  final FingerPrintController fingerPrintController = Get.put(FingerPrintController());
  final AuthController authController = Get.put(AuthController());
  final box = GetStorage();

  LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// Username and password text fields
            TextField(controller: authController.nameController ,decoration: const InputDecoration(labelText: 'Username')),
            TextField(controller: authController.passwordController ,decoration: const InputDecoration(labelText: 'Password')),
            const SizedBox(height: 30,),
            ElevatedButton(
              onPressed: () {
                UserModel user = UserModel(
                  username: authController.nameController.text,
                  password: authController.passwordController.text,
                );
                authController.checkAndLogin(user);
                Get.to(SettingsScreen());
              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 30,),
            Obx(() {
              // Show fingerprint logo conditionally
              if (authController.isFingerprintEnabled.value) {
                return IconButton(
                  icon: const Icon(Icons.fingerprint, size: 100, color: Colors.red,),
                  onPressed: () {},
                );
              } else{
                return Container();
              }
            }),
            const SizedBox(height: 30,),
            /// Fingerprint logo if supported
            // Obx(() {
            //   if (fingerPrintController.isFingerprintEnabled.value) {
            //     return IconButton(
            //       icon: const Icon(Icons.fingerprint, size: 100,),
            //       onPressed: () {
            //         /// Authenticate with fingerprint
            //         fingerPrintController.authenticateWithFingerprint(() {
            //           /// Handle authentication success and navigate accordingly
            //           Get.offNamed('/dashboard');
            //         });
            //       },
            //     );
            //   } else {
            //     return Container();
            //   }
            // }),

          ],
        ),
      ),
    );
  }
}
