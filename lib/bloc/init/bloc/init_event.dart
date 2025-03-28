part of 'init_bloc.dart';

@immutable
abstract class InitEvent {}

class InitTrip extends InitEvent {}

class StartTripEvent extends InitEvent {
  final String name;
  StartTripEvent(this.name);
}
