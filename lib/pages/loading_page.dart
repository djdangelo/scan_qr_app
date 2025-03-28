import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:scan_qr_app/bloc/bloc.dart';
import 'package:scan_qr_app/services/services.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoadingBloc(preferencesService: PreferencesService())
        ..add(LoadingInitEvent()),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocListener<LoadingBloc, LoadingState>(
          listener: (context, state) {
            if (state is LoadingNavigateToState) {
              context.go(state.route);
            }
          },
          child: const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
