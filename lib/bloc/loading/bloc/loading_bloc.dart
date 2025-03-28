import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:scan_qr_app/services/services.dart';

part 'loading_event.dart';
part 'loading_state.dart';

class LoadingBloc extends Bloc<LoadingEvent, LoadingState> {
  final PreferencesService preferencesService;

  LoadingBloc({required this.preferencesService}) : super(LoadingInitial()) {
    on<LoadingInitEvent>(_loading);
  }

  void _loading(LoadingInitEvent event, Emitter<LoadingState> emit) {
    if (preferencesService.getInit) {
      if (preferencesService.getIsAuthticate) {
        emit(LoadingNavigateToState('/home'));
      } else {
        emit(LoadingNavigateToState('/login'));
      }
    } else {
      emit(LoadingNavigateToState('/init'));
    }
  }
}
