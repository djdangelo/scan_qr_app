// ignore_for_file: override_on_non_overriding_member

part of 'auth_biometric_bloc.dart';

@immutable
sealed class AuthBiometricEvent {
  @override
  List<Object> get props => [];
}

class CheckBiometricEvent extends AuthBiometricEvent {}

class AuthenticateUserEvent extends AuthBiometricEvent {
  final String activeBiometric;

  AuthenticateUserEvent(this.activeBiometric);

  @override
  List<Object> get props => [activeBiometric];
}
