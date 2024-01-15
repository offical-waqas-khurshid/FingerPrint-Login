import 'package:fingerprint_login/UserModel.dart';
import 'package:fingerprint_login/app_setting.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';

import 'package:get/get.dart';

class AuthController extends GetxController {
  final box = GetStorage();
  RxBool isFingerprintEnabled = false.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> checkAndLogin(UserModel user) async {
    // Check if the entered data already exists in Get Storage
    if (checkIfDataExists(user)) {
      isFingerprintEnabled.value = true;
    } else {
      // If data does not exist, store it in Get Storage
      storeData(user);
    }

    Get.to(SettingsScreen());
  }


  bool checkIfDataExists(UserModel user) {
    UserModel? storedUser = getUserData();
    return storedUser != null &&
        storedUser.username == user.username &&
        storedUser.password == user.password;
  }

  void storeData(UserModel user) {
    box.write('user', user.toMap());
  }

  UserModel? getUserData() {
    Map<String, dynamic>? userData = box.read('user');
    return userData != null ? UserModel.fromMap(userData) : null;
  }
}
  //
  // bool checkIfDataExists(String username, String password) {
  //   String storedUsername = box.read('username');
  //   String storedPassword = box.read('password');
  //
  //   return storedUsername == username && storedPassword == password;
  // }
  //
  // void storeData(String username, String password) {
  //   box.write('username', username);
  //   box.write('password', password);
  // }

