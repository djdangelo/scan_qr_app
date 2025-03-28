part of 'loading_bloc.dart';

@immutable
abstract class LoadingState {}

final class LoadingInitial extends LoadingState {}

class LoadingErrorState extends LoadingState {
  final String message;
  LoadingErrorState(this.message);
}

class LoadingNavigateToState extends LoadingState {
  final String route;
  LoadingNavigateToState(this.route);
}
