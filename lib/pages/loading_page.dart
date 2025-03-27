import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_qr_app/controllers/controllers.dart';

class LoadingPage extends StatelessWidget {
  LoadingPage({Key? key}) : super(key: key);
  LoadingController loadingController = Get.put(LoadingController());

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      ),
    );
  }
}
