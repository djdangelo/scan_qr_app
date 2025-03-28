// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginSubmitEvent extends LoginEvent {
  final String password;
  LoginSubmitEvent(
    this.password,
  );
}

class CheckPasswordExistence extends LoginEvent {}
