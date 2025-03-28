import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:scan_qr_app/config/config.dart';
import 'package:scan_qr_app/services/services.dart';

part 'auth_biometric_event.dart';
part 'auth_biometric_state.dart';

class AuthBiometricBloc extends Bloc<AuthBiometricEvent, AuthBiometricState> {
  final PreferencesService preferencesService;

  AuthBiometricBloc({required this.preferencesService})
      : super(AuthBiometricInitial()) {
    on<CheckBiometricEvent>(_onCheckBiometric);
    on<AuthenticateUserEvent>(_onAuthenticateUser);
  }

  Future<void> _onCheckBiometric(
      CheckBiometricEvent event, Emitter<AuthBiometricState> emit) async {
    final canCheck = await LocalAuthPlugin.canCheckBiometric();
    emit(BiometricChecked(canCheck));
  }

  Future<void> _onAuthenticateUser(
      AuthenticateUserEvent event, Emitter<AuthBiometricState> emit) async {
    final (didAuthenticate, message) = await LocalAuthPlugin.authenticate();

    if (didAuthenticate) {
      if (event.activeBiometric == 'active') {
        preferencesService.setActiveBiometric = true;
        emit(AuthenticationSuccess());
      } else if (event.activeBiometric == 'desactive') {
        preferencesService.setActiveBiometric = false;
        emit(AuthenticationSuccess());
      } else if (event.activeBiometric == 'login') {
        preferencesService.setIsAuthticate = true;
        emit(AuthenticationSuccess());
      }
    } else {
      emit(AuthenticationFailed(message));
    }
  }
}
