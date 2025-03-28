import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:scan_qr_app/constants/constants.dart';
import 'package:scan_qr_app/controllers/controllers.dart';
import 'package:scan_qr_app/models/models.dart';
import 'package:scan_qr_app/pages/pages.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  GlobalButtonDecoartion button = GlobalButtonDecoartion();
  TextfieldDecorationConstant textFieldDecoration =
      TextfieldDecorationConstant();

  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    double withApp = MediaQuery.of(context).size.width;
    double heightApp = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(right: withApp * 0.1, left: withApp * 0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeInDown(
              duration: const Duration(milliseconds: 600),
              child: Center(
                  child: Text(
                '''Para poder inciar😎, ingresa una contraseña🫣, (nos servira para jackear la NASA BRO!! 🤫😂):''',
                style: TextStyle(
                    fontSize: heightApp * 0.025, fontWeight: FontWeight.bold),
              )),
            ),
            SizedBox(
              height: heightApp * 0.03,
            ),
            TextField(
              obscureText: true,
              keyboardType: TextInputType.text,
              controller: loginController.passwordController,
              decoration: textFieldDecoration.globalTextField(
                  data: TextFieldPropertiesModel(
                      hintText: 'Esfuerzate, creo en ti🫡...',
                      label: 'Imagina... 😁',
                      icon: FontAwesomeIcons.lock)),
            ),
            Divider(height: heightApp * 0.02, color: Colors.black),
            SizedBox(
              height: heightApp * 0.01,
            ),
            FadeInUp(
              duration: const Duration(milliseconds: 600),
              child: Column(
                children: [
                  ElevatedButton.icon(
                    style: button.globalButtonDecoration(withApp, heightApp),
                    icon: Icon(
                      FontAwesomeIcons.userCheck,
                      color: Colors.white,
                      size: heightApp * 0.03,
                    ),
                    onPressed: () => loginController.login(),
                    label: Obx(() => Text(loginController.textButton.value)),
                  ),
                  SizedBox(
                    height: heightApp * 0.01,
                  ),
                  ElevatedButton.icon(
                    style: button.globalButtonDecoration(withApp, heightApp),
                    icon: Icon(
                      FontAwesomeIcons.arrowRight,
                      color: Colors.white,
                      size: heightApp * 0.03,
                    ),
                    onPressed: () => Get.to(
                        () => AuthBiometricPage(optionBiometricData: 'login')),
                    label: const Text('BIOMETRIA! 😮'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
