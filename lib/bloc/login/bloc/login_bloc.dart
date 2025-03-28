import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:scan_qr_app/helpers/helpers.dart';
import 'package:scan_qr_app/services/services.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  StorageSecureHelper storageSecure;
  PreferencesService preferencesService;

  LoginBloc({required this.preferencesService, required this.storageSecure})
      : super(LoginInitial(existPass: false, buttonText: ' GUARDAR! 🤙🏽')) {
    on<LoginSubmitEvent>(_login);
    on<CheckPasswordExistence>(_onCheckPasswordExistence);
  }

  void _login(LoginSubmitEvent event, Emitter<LoginState> emit) async {
    if (event.password.isEmpty) {
      emit(LoginErrorState(
          'Oye!😓 No haz ingresado una contraseña valida ✍️, es importante para nuestro sistema🤩'));
      return;
    }
    if (state is LoginInitial && (state as LoginInitial).existPass) {
      final isValid =
          await storageSecure.validatePassword('password', event.password);
      if (!isValid) {
        emit(LoginErrorState('La contraseña que ingresaste no es válida.😫'));
        return;
      } else {
        emit(LoginNavigateToState('/home'));
        preferencesService.setIsAuthticate = true;
      }
    } else {
      await storageSecure.savePassword('password', event.password);
      preferencesService.setIsAuthticate = true;
      emit(LoginNavigateToState('/home'));
    }
  }

  void _onCheckPasswordExistence(
      CheckPasswordExistence event, Emitter<LoginState> emit) async {
    final existPass = await storageSecure.existPassword();
    final buttonText = existPass ? ' INICIAR 😃' : ' GUARDAR! 🤙🏽';
    emit(LoginInitial(existPass: existPass, buttonText: buttonText));
  }
}
