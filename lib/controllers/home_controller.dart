import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scan_qr_app/helpers/helpers.dart';
import 'package:scan_qr_app/pages/pages.dart';
import 'package:scan_qr_app/services/services.dart';

class HomeController extends GetxController {
  PreferencesService preferencesService = PreferencesService();
  StorageSecureHelper storageSecure = StorageSecureHelper();

  var now = DateTime.now();
  var message = ''.obs;

  var listData = [].obs;
  var showSpinner = false.obs;

  var selectedPage = 0.obs;

  var labelAction = ['Salir'].obs;

  getMessageWelcome() {
    var currentHour = DateFormat('HH').format(now);
    if (int.parse(currentHour) >= 01 && int.parse(currentHour) <= 11) {
      message.value = 'Buenos dias 😝 ${preferencesService.getNameUser}!';
    }
    if (int.parse(currentHour) >= 12 && int.parse(currentHour) <= 18) {
      message.value = 'Buenas tardes 😃 ${preferencesService.getNameUser}!';
    }
    if (int.parse(currentHour) >= 19 && int.parse(currentHour) <= 23) {
      message.value = 'Buenas noches 😴 ${preferencesService.getNameUser}!';
    }
    if (int.parse(currentHour) == 0) {
      message.value = 'Buenos noches 😴 ${preferencesService.getNameUser}!';
    }
  }

  actions(int actionValue) {
    if (actionValue == 0) {
      if (preferencesService.getActiveBiometric) {
        Get.snackbar(
            'Advertencia', 'Datos biometricos activos en la aplicacion.');
        return;
      }
      Get.to(() => AuthBiometricPage(optionBiometricData: 'active'));
    }
    if (actionValue == 1) {
      if (!preferencesService.getActiveBiometric) {
        Get.snackbar('Advertencia',
            'No hay datos biometricos activos en la aplicacion. Favor activelo');
        return;
      }
      Get.to(() => AuthBiometricPage(optionBiometricData: 'desactive'));
    }
    if (actionValue == 2) {
      //await storageSecure.deletePassword('password');
      Get.offAndToNamed('/login');
      preferencesService.logOut();
    }
  }

  @override
  void onInit() async {
    getMessageWelcome();
    super.onInit();
  }
}
