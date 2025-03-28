// ignore_for_file: must_be_immutable

part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {
  final bool existPass;
  final String buttonText;
  LoginInitial({required this.existPass, required this.buttonText});
}

class LoginErrorState extends LoginState {
  final String message;
  LoginErrorState(this.message);
}

class LoginNavigateToState extends LoginState {
  final String route;
  LoginNavigateToState(this.route);
}
