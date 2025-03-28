import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:scan_qr_app/bloc/bloc.dart';
import 'package:scan_qr_app/constants/constants.dart';
import 'package:scan_qr_app/helpers/helpers.dart';
import 'package:scan_qr_app/models/models.dart';
import 'package:scan_qr_app/services/services.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  GlobalButtonDecoartion button = GlobalButtonDecoartion();
  TextfieldDecorationConstant textFieldDecoration =
      TextfieldDecorationConstant();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double withApp = MediaQuery.of(context).size.width;
    double heightApp = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => LoginBloc(
          preferencesService: PreferencesService(),
          storageSecure: StorageSecureHelper())
        ..add(CheckPasswordExistence()),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  duration: const Duration(seconds: 5),
                  backgroundColor: Colors.black87,
                ),
              );
            }
            if (state is LoginNavigateToState) {
              context.go(state.route);
            }
          },
          builder: (context, state) {
            return Padding(
              padding:
                  EdgeInsets.only(right: withApp * 0.1, left: withApp * 0.1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FadeInDown(
                    duration: const Duration(milliseconds: 600),
                    child: Center(
                        child: Text(
                      '''Para poder inciar😎, ingresa una contraseña🫣, (nos servira para jackear la NASA BRO!! 🤫😂):''',
                      style: TextStyle(
                          fontSize: heightApp * 0.025,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                  SizedBox(
                    height: heightApp * 0.03,
                  ),
                  TextField(
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    controller: passwordController,
                    decoration: textFieldDecoration.globalTextField(
                        data: TextFieldPropertiesModel(
                            hintText: 'Esfuerzate, creo en ti🫡...',
                            label: 'Imagina... 😁',
                            icon: FontAwesomeIcons.lock)),
                  ),
                  Divider(height: heightApp * 0.02, color: Colors.black),
                  SizedBox(
                    height: heightApp * 0.01,
                  ),
                  FadeInUp(
                    duration: const Duration(milliseconds: 600),
                    child: Column(
                      children: [
                        ElevatedButton.icon(
                          style:
                              button.globalButtonDecoration(withApp, heightApp),
                          icon: Icon(
                            FontAwesomeIcons.userCheck,
                            color: Colors.white,
                            size: heightApp * 0.03,
                          ),
                          onPressed: () => context
                              .read<LoginBloc>()
                              .add(LoginSubmitEvent(passwordController.text)),
                          label: BlocBuilder<LoginBloc, LoginState>(
                            builder: (context, state) {
                              if (state is LoginInitial) {
                                return Text(state.buttonText);
                              }
                              return const Text(' INICIAR 😃');
                            },
                          ),
                        ),
                        SizedBox(
                          height: heightApp * 0.01,
                        ),
                        ElevatedButton.icon(
                          style:
                              button.globalButtonDecoration(withApp, heightApp),
                          icon: Icon(
                            FontAwesomeIcons.arrowRight,
                            color: Colors.white,
                            size: heightApp * 0.03,
                          ),
                          onPressed: () => context.goNamed('biometric',
                              pathParameters: {'data': 'login'}),
                          label: const Text('BIOMETRIA! 😮'),
                        ),
                      ],
                    ),
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
