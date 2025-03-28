import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:scan_qr_app/constants/constants.dart';
import 'package:scan_qr_app/controllers/controllers.dart';

class ScanQrPage extends StatelessWidget {
  ScanQrPage({super.key});
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  GlobalButtonDecoartion button = GlobalButtonDecoartion();
  ScanQrController scanController = Get.put(ScanQrController());

  @override
  Widget build(BuildContext context) {
    double withApp = MediaQuery.of(context).size.width;
    double heightApp = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Escaner de QR', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_sharp,
            color: Colors.black,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: QRView(
              key: qrKey,
              onQRViewCreated: scanController.onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Obx(() => Center(
                  child: Text(
                    'Código escaneado: ${scanController.scannedData.value}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FadeInUp(
              duration: const Duration(milliseconds: 600),
              child: ElevatedButton.icon(
                style: button.globalButtonDecoration(withApp, heightApp),
                icon: Icon(
                  FontAwesomeIcons.cloud,
                  color: Colors.white,
                  size: heightApp * 0.03,
                ),
                onPressed: () => scanController.saveData(),
                label: const Text(
                  ' GUARDAR! 👻',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
