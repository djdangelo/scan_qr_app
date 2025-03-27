import 'package:get/get.dart';
import 'package:scan_qr_app/services/services.dart';

class LoadingController extends GetxController {
  PreferencesService preferencesService = PreferencesService();

  @override
  void onInit() {
    loading();
    super.onInit();
  }

  loading() {
    if (preferencesService.getInit) {
      if (preferencesService.getIsAuthticate) {
        Future.delayed(Duration.zero, () {
          Get.offAllNamed('/home');
        });
        return;
      }
      Future.delayed(Duration.zero, () {
        Get.offAllNamed('/login');
      });
    } else {
      Future.delayed(Duration.zero, () {
        Get.offAllNamed('/init');
      });
    }
  }
}
