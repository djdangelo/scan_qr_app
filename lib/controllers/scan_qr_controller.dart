import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:scan_qr_app/controllers/controllers.dart';
import 'package:scan_qr_app/models/models.dart';
import 'package:scan_qr_app/services/services.dart';

class ScanQrController extends GetxController {
  QrDataService qrDataService = QrDataService();
  HomeController homeController = Get.put(HomeController());

  var scannedData = ''.obs;
  QRViewController? controller;
  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      scannedData.value = scanData.code ?? "Código inválido";
      controller.pauseCamera(); // Pausar la cámara después de escanear
    });
  }

  void resumeCamera() {
    controller?.resumeCamera();
  }

  saveData() async {
    if (scannedData.value.isEmpty) {
      Get.snackbar(
        'Ops! Hay un problema 🥴',
        'Oye!😓 Revisa el escaneo del QR, parece que no esta trayendo datos. 🥲',
        duration: const Duration(milliseconds: 10000),
        borderRadius: 1.0,
        colorText: Colors.black,
        icon: const Icon(FontAwesomeIcons.info),
      );
      return;
    }
    QrDataModel data = QrDataModel(
        value: scannedData.value,
        createAt: DateTime.now().toString(),
        status: 1);

    try {
      await qrDataService.create(data);
      Get.snackbar(
        'Informacion',
        'Se ha guardado correctamente el registro. 🤩',
        duration: const Duration(milliseconds: 10000),
        borderRadius: 1.0,
        colorText: Colors.black,
        icon: const Icon(FontAwesomeIcons.info),
      );
      resumeCamera();
      homeController.getData();
    } catch (e) {
      Get.snackbar(
        'Error 😭',
        'Ha ocurrido un error al intentar guardar el registro. 😰 Intenta de nuevo en un momento. 😥',
        duration: const Duration(milliseconds: 10000),
        borderRadius: 1.0,
        colorText: Colors.black,
        icon: const Icon(FontAwesomeIcons.warning),
      );
    }
  }

  @override
  void onClose() {
    controller?.dispose();
    super.onClose();
  }
}
