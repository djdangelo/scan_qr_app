part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class GetMessageWelcomeEvent extends HomeEvent {}

class GetDataEvent extends HomeEvent {}

class ActionEvent extends HomeEvent {
  final int actionValue;

  ActionEvent(this.actionValue);
}

class OpenScanQrEvent extends HomeEvent {}
