part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

final class HomeInitial extends HomeState {}

class MessageWelcomeState extends HomeState {
  final String message;
  MessageWelcomeState(this.message);
}

class LoadingProgressState extends HomeState {}

class DataLoadedState extends HomeState {
  final List<QrDataModel> listData;
  DataLoadedState(this.listData);
}

class ErrorState extends HomeState {
  final String message;
  ErrorState(this.message);
}

class NavigateToState extends HomeState {
  final String route;
  NavigateToState(this.route);
}
