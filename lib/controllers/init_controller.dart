import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:scan_qr_app/services/services.dart';

class InitController extends GetxController {
  PreferencesService preferencesService = PreferencesService();

  var nameUserTextController = TextEditingController();

  initTrip() {
    if (nameUserTextController.text.isEmpty) {
      Get.snackbar(
        'Iniciamos mal!🥴',
        'Oye!😓 Dinos como quieres que nos dirijamos a ti ✍️, es importante para nuestro sistema🤩',
        duration: const Duration(milliseconds: 10000),
        borderRadius: 1.0,
        colorText: Colors.black,
        icon: const Icon(FontAwesomeIcons.info),
      );
      return;
    }
    preferencesService.setInit = true;
    preferencesService.setNameUser = nameUserTextController.text;
    Get.offAndToNamed('/login');
  }
}
