import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:scan_qr_app/bloc/bloc.dart';
import 'package:scan_qr_app/constants/constants.dart';

class ScanQrPage extends StatelessWidget {
  ScanQrPage({super.key});
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  GlobalButtonDecoartion button = GlobalButtonDecoartion();

  @override
  Widget build(BuildContext context) {
    double withApp = MediaQuery.of(context).size.width;
    double heightApp = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Escaner de QR', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_sharp,
            color: Colors.black,
          ),
          onPressed: () => context.pop(),
        ),
      ),
      backgroundColor: Colors.white,
      body: BlocConsumer<ScanQrBloc, ScanQrState>(
        listener: (context, state) {
          if (state is ScanQrErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                duration: const Duration(seconds: 5),
                backgroundColor: Colors.black87,
              ),
            );
          }
          if (state is ScanQrSaved) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('QR guardado exitosamente 🎉')),
            );
            context.replace('/home');
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                flex: 4,
                child: QRView(
                  key: qrKey,
                  onQRViewCreated: (controller) {
                    context.read<ScanQrBloc>().add(StartScanning(controller));
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    state is ScanQrScanning
                        ? 'Código escaneado: ${state.scannedData}'
                        : 'Escanea un código QR',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FadeInUp(
                  duration: const Duration(milliseconds: 600),
                  child: ElevatedButton.icon(
                    style: button.globalButtonDecoration(withApp, heightApp),
                    icon: Icon(
                      FontAwesomeIcons.cloud,
                      color: Colors.white,
                      size: heightApp * 0.03,
                    ),
                    onPressed: state is ScanQrScanning
                        ? () =>
                            context.read<ScanQrBloc>().add(SaveScannedData())
                        : null,
                    label: const Text(
                      ' GUARDAR! 👻',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
