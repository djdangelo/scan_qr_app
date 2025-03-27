import 'package:permission_handler/permission_handler.dart';

class PermissionCameraHelper {
  Future<bool> isPermissionGranted() async {
    final isGranted = await Permission.camera.isGranted;
    return isGranted;
  }

  requestCameraAccess() async {
    final status = await Permission.camera.request();
    _checkPermissionState(status);
  }

  void _checkPermissionState(PermissionStatus status) async {
    if (status == PermissionStatus.permanentlyDenied) {
      await openAppSettings();
    }
  }
}
