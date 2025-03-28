import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:scan_qr_app/helpers/helpers.dart';
import 'package:scan_qr_app/models/models.dart';
import 'package:flutter/material.dart';
import 'package:scan_qr_app/services/services.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final PreferencesService preferencesService;
  final StorageSecureHelper storageSecure;
  final QrDataService qrDataService;
  final PermissionCameraHelper permission;

  HomeBloc({
    required this.preferencesService,
    required this.storageSecure,
    required this.qrDataService,
    required this.permission,
  }) : super(HomeInitial()) {
    on<GetMessageWelcomeEvent>(_getMessageWelcome);
    on<GetDataEvent>(_getData);
    on<ActionEvent>(_handleAction);
    on<OpenScanQrEvent>(_scanQr);

    add(GetMessageWelcomeEvent());
    add(GetDataEvent());
  }

  void _getMessageWelcome(
      GetMessageWelcomeEvent event, Emitter<HomeState> emit) {
    final now = DateTime.now();
    final currentHour = int.parse(DateFormat('HH').format(now));
    String message;

    if (currentHour >= 1 && currentHour <= 11) {
      message = 'Buenos días 😝 ${preferencesService.getNameUser}!';
    } else if (currentHour >= 12 && currentHour <= 18) {
      message = 'Buenas tardes 😃 ${preferencesService.getNameUser}!';
    } else {
      message = 'Buenas noches 😴 ${preferencesService.getNameUser}!';
    }

    emit(MessageWelcomeState(message));
  }

  Future<void> _getData(GetDataEvent event, Emitter<HomeState> emit) async {
    emit(LoadingProgressState());
    try {
      final listData = await qrDataService.getData();
      emit(DataLoadedState(listData));
    } catch (e) {
      emit(
          ErrorState('Error al cargar los datos. Intenta de nuevo más tarde.'));
    }
  }

  void _handleAction(ActionEvent event, Emitter<HomeState> emit) {
    if (event.actionValue == 0) {
      if (preferencesService.getActiveBiometric) {
        emit(ErrorState('Datos biométricos ya están activos.'));
      } else {
        emit(NavigateToState('/auth-biometric'));
      }
    } else if (event.actionValue == 1) {
      if (!preferencesService.getActiveBiometric) {
        emit(
            ErrorState('No hay datos biométricos activos. Actívelos primero.'));
      } else {
        emit(NavigateToState('/auth-biometric'));
      }
    } else if (event.actionValue == 2) {
      preferencesService.logOut();
      emit(NavigateToState('/login'));
    }
  }

  Future<void> _scanQr(OpenScanQrEvent event, Emitter<HomeState> emit) async {
    if (!await permission.isPermissionGranted()) {
      await permission.requestCameraAccess();
    }
    emit(NavigateToState('/scan-qr'));
  }
}
