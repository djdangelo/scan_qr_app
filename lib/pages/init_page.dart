import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scan_qr_app/constants/constants.dart';
import 'package:scan_qr_app/models/models.dart';

// ignore: must_be_immutable
class InitPage extends StatelessWidget {
  InitPage({super.key});
  GlobalButtonDecoartion button = GlobalButtonDecoartion();
  TextfieldDecorationConstant textFieldDecoration =
      TextfieldDecorationConstant();

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
                '''Hola👋, iniciemos a Escanear codigos QR! 😎 
Dinos 🫡, como quieres que me dirija a ti 👻:''',
                style: TextStyle(
                    fontSize: heightApp * 0.025, fontWeight: FontWeight.bold),
              )),
            ),
            SizedBox(
              height: heightApp * 0.03,
            ),
            TextField(
              obscureText: false,
              keyboardType: TextInputType.text,
              maxLength: 12,
              decoration: textFieldDecoration.globalTextField(
                  data: TextFieldPropertiesModel(
                      hintText: 'Puedes usar tu nombre, apodo...',
                      label: 'Imagina... 😁',
                      icon: FontAwesomeIcons.userAstronaut)),
            ),
            Divider(height: heightApp * 0.02, color: Colors.black),
            SizedBox(
              height: heightApp * 0.01,
            ),
            FadeInUp(
              duration: const Duration(milliseconds: 600),
              child: ElevatedButton.icon(
                style: button.globalButtonDecoration(withApp, heightApp),
                icon: Icon(
                  FontAwesomeIcons.arrowRight,
                  color: Colors.white,
                  size: heightApp * 0.03,
                ),
                onPressed: () {},
                label: const Text('VAMOOOS! 🚀'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
