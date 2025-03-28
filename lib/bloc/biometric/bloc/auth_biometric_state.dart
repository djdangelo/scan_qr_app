// ignore_for_file: override_on_non_overriding_member

part of 'auth_biometric_bloc.dart';

@immutable
abstract class AuthBiometricState {
  @override
  List<Object> get props => [];
}

final class AuthBiometricInitial extends AuthBiometricState {}

class BiometricChecked extends AuthBiometricState {
  final bool canCheckBiometric;

  BiometricChecked(this.canCheckBiometric);

  @override
  List<Object> get props => [canCheckBiometric];
}

class AuthenticationSuccess extends AuthBiometricState {}

class AuthenticationFailed extends AuthBiometricState {
  final String message;

  AuthenticationFailed(this.message);

  @override
  List<Object> get props => [message];
}
