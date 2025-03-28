import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scan_qr_app/bloc/bloc.dart';
import 'package:scan_qr_app/config/routes/app_router.dart';
import 'package:scan_qr_app/helpers/helpers.dart';
import 'package:scan_qr_app/services/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  PreferencesService preferencesService = PreferencesService();
  await preferencesService.initPreferences();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) =>
                AuthBiometricBloc(preferencesService: PreferencesService())),
        BlocProvider(
            create: (_) => HomeBloc(
                  permission: PermissionCameraHelper(),
                  preferencesService: PreferencesService(),
                  qrDataService: QrDataService(),
                  storageSecure: StorageSecureHelper(),
                )),
        BlocProvider(
            create: (_) => InitBloc(preferencesService: PreferencesService())),
        BlocProvider(
            create: (_) =>
                LoadingBloc(preferencesService: PreferencesService())),
        BlocProvider(
            create: (_) =>
                LoadingBloc(preferencesService: PreferencesService())),
        BlocProvider(
            create: (_) => LoginBloc(
                preferencesService: PreferencesService(),
                storageSecure: StorageSecureHelper())),
        BlocProvider(create: (_) => ScanQrBloc(QrDataService())),
      ],
      child: MaterialApp.router(
        darkTheme: ThemeData.light(useMaterial3: false),
        theme: ThemeData.light(useMaterial3: false),
        debugShowCheckedModeBanner: false,
        title: 'Scan QR',
        routerConfig: appRouter,
      ),
    );
  }
}
