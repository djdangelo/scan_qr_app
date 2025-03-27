import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:scan_qr_app/config/config.dart';
import 'package:scan_qr_app/services/services.dart';

void main() async {
  // ignore: unused_local_variable
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  PreferencesService preferencesService = PreferencesService();
  await preferencesService.initPreferences();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(GetMaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.light(useMaterial3: false),
      theme: ThemeData.light(useMaterial3: false),
      title: 'Scan QR',
      initialRoute: '/loading',
      getPages: appRouters));
}
