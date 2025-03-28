import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:scan_qr_app/bloc/bloc.dart';
import 'package:scan_qr_app/constants/constants.dart';
import 'package:scan_qr_app/services/services.dart';

// ignore: must_be_immutable
class AuthBiometricPage extends StatelessWidget {
  AuthBiometricPage({super.key, required this.optionBiometricData});

  final String optionBiometricData;

  GlobalButtonDecoartion button = GlobalButtonDecoartion();

  @override
  Widget build(BuildContext context) {
    double withApp = MediaQuery.of(context).size.width;
    double heightApp = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) =>
          AuthBiometricBloc(preferencesService: PreferencesService())
            ..add(CheckBiometricEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Autenticador local 🤪',
              style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
          elevation: 0.5,
          centerTitle: true,
          leading: (optionBiometricData == 'login')
              ? const SizedBox()
              : IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_sharp,
                    color: Colors.black,
                  ),
                  onPressed: () => context.pop(),
                ),
        ),
        backgroundColor: Colors.white,
        body: BlocConsumer<AuthBiometricBloc, AuthBiometricState>(
          listener: (context, state) {
            if (state is AuthenticationSuccess) {
              if (optionBiometricData == 'login') {
                context.replace('/home');
              }
            }
            if (state is AuthenticationFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FadeInUp(
                    duration: const Duration(milliseconds: 600),
                    child: ElevatedButton.icon(
                      style: button.globalButtonDecoration(withApp, heightApp),
                      icon: Icon(
                        FontAwesomeIcons.userLock,
                        color: Colors.white,
                        size: heightApp * 0.03,
                      ),
                      onPressed: () {
                        context.read<AuthBiometricBloc>().add(
                              AuthenticateUserEvent(optionBiometricData),
                            );
                      },
                      label: const Text(
                        ' AUTENTICAR!',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  BlocBuilder<AuthBiometricBloc, AuthBiometricState>(
                    builder: (context, state) {
                      if (state is BiometricChecked) {
                        return SizedBox(
                          width: withApp,
                          height: heightApp * 0.1,
                          child: Center(
                            child: Text(
                              state.canCheckBiometric
                                  ? 'Hey, sí tienes datos biométricos activos. 😎'
                                  : 'F, no tienes datos biométricos activos. 😭',
                              style: TextStyle(
                                fontSize: heightApp * 0.02,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      }
                      return SizedBox();
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
