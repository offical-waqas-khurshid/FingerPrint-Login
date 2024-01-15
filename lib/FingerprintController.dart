import 'package:fingerprint_login/FingerprintScreen.dart';
import 'package:fingerprint_login/Login.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

class FingerPrintController extends GetxController {
  final LocalAuthentication _localAuth = LocalAuthentication();
  RxBool isAuthenticated = false.obs;
  RxBool isFingerprintSupported = false.obs;
  RxBool isFingerprintEnabled = false.obs;

  TextEditingController passwordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    checkFingerprintSupport();
  }


  void onPasswordSubmitted() {
   /// Handle password submission here
    //Get.to(BiometricScreen());
  }


  Future<void> checkBiometrics() async {
    bool canCheckBiometrics;
    try {
      canCheckBiometrics = await _localAuth.canCheckBiometrics;
    } catch (e) {
      print(e);
      return;
    }
    if (!canCheckBiometrics) {
      // Biometrics not available on this device
      return;
    }
    List<BiometricType> availableBiometrics = await _localAuth.getAvailableBiometrics();
    print('Available biometrics: $availableBiometrics');
  }

  Future<void> authenticate() async {
    try {
      bool authenticated = await _localAuth.authenticate(
        localizedReason: 'Authenticate to access the app',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
          useErrorDialogs: true,
        ),
      );
      isAuthenticated.value = authenticated;
      if (authenticated) {
        Get.to(LoginScreen());
      } else {
        Get.snackbar("Error", "Your are not authorized");
      }
    } catch (e) {
      print(e);
    }
  }

  /// Check Fingerprint support device or not
  Future<void> checkFingerprintSupport() async {
    bool canCheckBiometrics = await _localAuth.isDeviceSupported();
    isFingerprintSupported.value = canCheckBiometrics;
  }

  /// Authenticate to user
  Future<void> authenticateWithFingerprint(Function onSuccess) async {
    bool didAuthenticate = await _localAuth.authenticate(
      localizedReason: 'Authenticate with fingerprint',
      options: const AuthenticationOptions(
        stickyAuth: true,
        biometricOnly: true,
        useErrorDialogs: true,
      ),
    );

    if (didAuthenticate) {
      isFingerprintEnabled.value = true;
      onSuccess();
    } else {
      // Handle authentication failure
      Get.snackbar('Authentication failed', 'Fingerprint not recognized');
    }
  }
}