import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:scan_qr_app/helpers/helpers.dart';
import 'package:scan_qr_app/services/services.dart';

class LoginController extends GetxController {
  TextEditingController passwordController = TextEditingController();
  StorageSecureHelper storageSecure = StorageSecureHelper();
  PreferencesService preferencesService = PreferencesService();

  bool existPass = false;
  var textButton = ' GUARDAR! 🤙🏽'.obs;

  login() async {
    if (passwordController.text.isEmpty) {
      return Get.snackbar(
        'Iniciamos mal!🥴',
        'Oye!😓 No haz ingresado una contraseña valida ✍️, es importante para nuestro sistema🤩',
        duration: const Duration(milliseconds: 10000),
        borderRadius: 1.0,
        colorText: Colors.black,
        icon: const Icon(FontAwesomeIcons.info),
      );
    }
    if (existPass) {
      if (!await storageSecure.validatePassword(
          'password', passwordController.text)) {
        return Get.snackbar(
          'Vamos mal!🥴',
          'La contraseña que ingresaste no es valida.😫',
          duration: const Duration(milliseconds: 10000),
          borderRadius: 1.0,
          colorText: Colors.black,
          icon: const Icon(FontAwesomeIcons.info),
        );
      } else {
        Get.offAndToNamed('/home');
        preferencesService.setIsAuthticate = true;
      }
    } else {
      await storageSecure.savePassword('password', passwordController.text);
      preferencesService.setIsAuthticate = true;
      Get.offAndToNamed('/home');
    }
  }

  @override
  void onInit() async {
    existPass = await storageSecure.existPassword();
    if (existPass) {
      textButton.value = ' INICIAR 😃';
    }
    super.onInit();
  }
}
