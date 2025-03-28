part of 'scan_qr_bloc.dart';

@immutable
abstract class ScanQrState {}

final class ScanQrInitial extends ScanQrState {}

class ScanQrScanning extends ScanQrState {
  final String scannedData;
  ScanQrScanning(this.scannedData);
}

class ScanQrSaved extends ScanQrState {}

class ScanQrErrorState extends ScanQrState {
  final String message;
  ScanQrErrorState(this.message);
}

class StartScanning extends ScanQrEvent {
  final QRViewController controller;
  StartScanning(this.controller);
}
