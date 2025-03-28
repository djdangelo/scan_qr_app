part of 'scan_qr_bloc.dart';

@immutable
abstract class ScanQrEvent {}

class QRScanned extends ScanQrEvent {
  final String scannedData;
  QRScanned(this.scannedData);
}

class SaveScannedData extends ScanQrEvent {}

class ResumeCamera extends ScanQrEvent {}
