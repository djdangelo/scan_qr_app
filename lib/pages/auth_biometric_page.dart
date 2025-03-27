import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:scan_qr_app/constants/constants.dart';
import 'package:scan_qr_app/controllers/controllers.dart';

// ignore: must_be_immutable
class AuthBiometricPage extends StatelessWidget {
  AuthBiometricPage({super.key, required this.optionBiometricData});

  final String optionBiometricData;

  AuthBiometricController authBiometricController =
      Get.put(AuthBiometricController());
  GlobalButtonDecoartion button = GlobalButtonDecoartion();

  @override
  Widget build(BuildContext context) {
    double withApp = MediaQuery.of(context).size.width;
    double heightApp = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Autenticador local 🤪',
            style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        leading: (optionBiometricData == 'login')
            ? const SizedBox()
            : IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_sharp,
                  color: Colors.black,
                ),
                onPressed: () => Get.back(),
              ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeInUp(
              duration: const Duration(milliseconds: 600),
              child: ElevatedButton.icon(
                style: button.globalButtonDecoration(withApp, heightApp),
                icon: Icon(
                  FontAwesomeIcons.userLock,
                  color: Colors.white,
                  size: heightApp * 0.03,
                ),
                onPressed: () async =>
                    await authBiometricController.authUser(optionBiometricData),
                label: const Text(
                  ' AUTENTICAR!',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Obx(() => (authBiometricController.canCheckBiometricInit.isFalse)
                ? SizedBox(
                    width: withApp,
                    height: heightApp * 0.1,
                    child: Center(
                      child: Text('F, no tienes datos biometricos activos. 😭',
                          style: TextStyle(
                            fontSize: heightApp * 0.02,
                            fontWeight: FontWeight.bold,
                          )),
                    ))
                : SizedBox(
                    width: withApp,
                    height: heightApp * 0.1,
                    child: Center(
                      child:
                          Text('Hey, si tienes datos biometricos activos. 😎',
                              style: TextStyle(
                                fontSize: heightApp * 0.02,
                                fontWeight: FontWeight.bold,
                              )),
                    ))),
          ],
        ),
      ),
    );
  }
}
