import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:scan_qr_app/services/services.dart';

part 'init_event.dart';
part 'init_state.dart';

class InitBloc extends Bloc<InitEvent, InitState> {
  final PreferencesService preferencesService;

  InitBloc({required this.preferencesService}) : super(InitInitial()) {
    on<StartTripEvent>(_onStartTrip);
  }

  void _onStartTrip(StartTripEvent event, Emitter<InitState> emit) {
    if (event.name.isEmpty) {
      emit(InitErrorState(
        'Oye!😓 Dinos cómo quieres que nos dirijamos a ti ✍️, es importante para nuestro sistema🤩',
      ));
      return;
    }

    preferencesService.setInit = true;
    preferencesService.setNameUser = event.name;
    emit(InitNavigateToState('/login'));
  }
}
