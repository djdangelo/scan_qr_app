import 'package:flutter/material.dart';
import 'package:scan_qr_app/models/models.dart';

class TextfieldDecorationConstant {
  InputDecoration globalTextField({required TextFieldPropertiesModel data}) {
    return InputDecoration(
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(1.0))),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black26),
            borderRadius: BorderRadius.all(Radius.circular(1.0))),
        hintText: data.hintText,
        hintStyle: const TextStyle(color: Colors.black),
        labelStyle: const TextStyle(color: Colors.black),
        labelText: data.label,
        prefixIcon: Icon(
          data.icon,
          color: Colors.black,
        ));
  }
}
