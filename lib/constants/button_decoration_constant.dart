import 'package:flutter/material.dart';

class GlobalButtonDecoartion {
  ButtonStyle globalButtonDecoration(double withButtom, double height) {
    return ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        backgroundColor: Colors.black,
        textStyle:
            TextStyle(fontSize: height * 0.03, fontWeight: FontWeight.bold),
        elevation: 3.0,
        fixedSize: Size(withButtom * 0.9, height * 0.06));
  }
}
