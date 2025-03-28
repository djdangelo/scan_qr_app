part of 'init_bloc.dart';

@immutable
abstract class InitState {}

final class InitInitial extends InitState {}

class InitErrorState extends InitState {
  final String message;
  InitErrorState(this.message);
}

class InitNavigateToState extends InitState {
  final String route;
  InitNavigateToState(this.route);
}
