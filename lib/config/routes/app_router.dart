import 'package:get/get.dart';
import 'package:scan_qr_app/pages/pages.dart';

List<GetPage<dynamic>> appRouters = [
  GetPage(
    name: '/loading',
    page: () => LoadingPage(),
  ),
  GetPage(
    name: '/home',
    page: () => HomePage(),
  ),
  GetPage(
    name: '/init',
    page: () => InitPage(),
  ),
  GetPage(
    name: '/login',
    page: () => LoginPage(),
  ),
  GetPage(
    name: '/scan-qr',
    page: () => ScanQrPage(),
  )
];
