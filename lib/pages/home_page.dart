import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:scan_qr_app/bloc/bloc.dart';
import 'package:scan_qr_app/widgets/widget.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double heightApp = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio', style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
        elevation: 0.3,
        leading: const Icon(FontAwesomeIcons.house),
        iconTheme: const IconThemeData(color: Colors.black87),
        actions: [
          PopupMenuButton(onSelected: (value) {
            if (value == 'Salir') {
              context.read<HomeBloc>().add(ActionEvent(2));
            }
          }, itemBuilder: (BuildContext context) {
            return ['Salir'].map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList();
          })
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(heightApp * 0.01),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SafeArea(
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is MessageWelcomeState) {
                    return HeaderCardWidget(textShow: state.message);
                  }
                  return HeaderCardWidget(textShow: 'Cargando...');
                },
              ),
            ),
            Divider(height: heightApp * 0.02, color: Colors.black),
            Expanded(
              child: BlocListener<HomeBloc, HomeState>(
                listener: (context, state) {
                  if (state is ErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        duration: const Duration(seconds: 5),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }

                  if (state is NavigateToState) {
                    context.goNamed(state.route);
                  }
                },
                child: BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state is LoadingProgressState) {
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.black),
                      );
                    }
                    if (state is DataLoadedState) {
                      if (state.listData.isEmpty) {
                        return const Center(
                          child: Text('No hay datos que mostrar.'),
                        );
                      }
                      return CardListDataWidget(listData: state.listData);
                    }
                    return const Center(child: Text("Cargando datos..."));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: MaterialButton(
          color: Colors.black,
          minWidth: 120,
          height: 50,
          elevation: 0,
          shape: const StadiumBorder(),
          onPressed: () => context.read<HomeBloc>().add(OpenScanQrEvent()),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'ESCANEAR QR',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 4.0,
              ),
              Icon(FontAwesomeIcons.plus, color: Colors.white)
            ],
          )),
    );
  }
}
