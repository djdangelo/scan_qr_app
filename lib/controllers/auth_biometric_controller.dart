import 'package:get/get.dart';
import 'package:scan_qr_app/config/config.dart';
import 'package:scan_qr_app/services/services.dart';

class AuthBiometricController extends GetxController {
  var canCheckBiometricInit = false.obs;
  PreferencesService preferencesService = PreferencesService();

  static Future<bool> canCheckBiometric() async {
    return await LocalAuthPlugin.canCheckBiometric();
  }

  Future<(bool, String)> authUser(String activeBiometric) async {
    final (didAuthenticate, message) = await LocalAuthPlugin.authenticate();

    if (didAuthenticate && activeBiometric == 'active') {
      preferencesService.setActiveBiometric = true;
      Get.back();
    }
    if (didAuthenticate && activeBiometric == 'desactive') {
      preferencesService.setActiveBiometric = false;
      Get.back();
    }
    if (didAuthenticate && activeBiometric == 'login') {
      Get.offAllNamed('/home');
      preferencesService.setIsAuthticate = true;
    }
    return (didAuthenticate, message);
  }

  @override
  void onInit() async {
    canCheckBiometricInit.value = await canCheckBiometric();
    super.onInit();
  }
}
