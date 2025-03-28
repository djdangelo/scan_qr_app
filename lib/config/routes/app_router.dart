import 'package:go_router/go_router.dart';
import 'package:scan_qr_app/pages/pages.dart';

final appRouter = GoRouter(initialLocation: '/loading', routes: [
  GoRoute(
    path: '/loading',
    builder: (context, state) => const LoadingPage(),
  ),
  GoRoute(
    path: '/home',
    builder: (context, state) => HomePage(),
  ),
  GoRoute(
    path: '/init',
    builder: (context, state) => InitPage(),
  ),
  GoRoute(
    path: '/login',
    builder: (context, state) => LoginPage(),
  ),
  GoRoute(
    path: '/scan-qr',
    builder: (context, state) => ScanQrPage(),
  ),
  GoRoute(
    path: '/biometric/:data',
    builder: (context, state) => AuthBiometricPage(
        optionBiometricData: state.pathParameters['data'] ?? ''),
  )
]);
