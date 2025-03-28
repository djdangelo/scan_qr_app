import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:scan_qr_app/models/models.dart';
import 'package:scan_qr_app/services/services.dart';

part 'scan_qr_event.dart';
part 'scan_qr_state.dart';

class ScanQrBloc extends Bloc<ScanQrEvent, ScanQrState> {
  final QrDataService qrDataService;
  QRViewController? controller;

  ScanQrBloc(this.qrDataService) : super(ScanQrInitial()) {
    on<QRScanned>(_onQRScanned);
    on<SaveScannedData>(_onSaveScannedData);
    on<ResumeCamera>(_onResumeCamera);
  }

  void _onQRScanned(QRScanned event, Emitter<ScanQrState> emit) {
    final scannedText =
        event.scannedData.isNotEmpty ? event.scannedData : "Código inválido";
    emit(ScanQrScanning(scannedText));
    controller?.stopCamera();
  }

  void _onResumeCamera(ResumeCamera event, Emitter<ScanQrState> emit) {
    controller?.resumeCamera();
    emit(ScanQrInitial());
  }

  Future<void> _onSaveScannedData(
      SaveScannedData event, Emitter<ScanQrState> emit) async {
    if (state is ScanQrScanning) {
      final scannedData = (state as ScanQrScanning).scannedData;
      if (scannedData.isEmpty || scannedData == "Código inválido") {
        emit(ScanQrErrorState(
            'Ops! 😓 El código QR escaneado no contiene datos válidos.'));
        return;
      }

      final data = QrDataModel(
        value: scannedData,
        createAt: DateTime.now().toString(),
        status: 1,
      );

      try {
        await qrDataService.create(data);
        emit(ScanQrSaved());
      } catch (e) {
        emit(ScanQrErrorState(
            'Error 😭 No se pudo guardar el registro. Intenta nuevamente.'));
      }
    }
  }

  void _onStartScanning(StartScanning event, Emitter<ScanQrState> emit) {
    controller = event.controller;
    controller?.scannedDataStream.listen((scanData) {
      if (scanData.code != null) {
        add(QRScanned(scanData.code!));
      }
    });
  }
}
