import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

class LocalAuthPlugin {
  static final LocalAuthentication auth = LocalAuthentication();

  static availableBiometric() async {
    final List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();

    if (availableBiometrics.isNotEmpty) {
      // Some biometrics are enrolled.
    }

    if (availableBiometrics.contains(BiometricType.strong) ||
        availableBiometrics.contains(BiometricType.face)) {
      // Specific types of biometrics are available.
      // Use checks like this with caution!
    }
  }

  static Future<bool> canCheckBiometric() async {
    return await auth.canCheckBiometrics;
  }

  static Future<(bool, String)> authenticate() async {
    try {
      final bool didAuthenticate = await auth.authenticate(
          localizedReason: 'Por favor autenticate para continuar.',
          options: const AuthenticationOptions());
      return (
        didAuthenticate,
        didAuthenticate ? 'Hecho' : 'Cancelado por el usuario.'
      );
    } on PlatformException catch (e) {
      print(e);
      if (e.code == auth_error.notEnrolled) {
        return (false, 'No hay biometricos registrados.');
      }
      if (e.code == auth_error.lockedOut) {
        return (false, 'Bloqueado por intentos fallidos.');
      }
      if (e.code == auth_error.notAvailable) {
        return (false, 'No hay biometricos disponibles.');
      }
      if (e.code == auth_error.passcodeNotSet) {
        return (false, 'No hay contrasenas registradas.');
      }
      if (e.code == auth_error.permanentlyLockedOut) {
        return (false, 'Se requiere desbloquear el telefono.');
      }
      return (false, e.toString());
    }
  }
}
