import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:scan_qr_app/controllers/home_controller.dart';
import 'package:scan_qr_app/widgets/widget.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({super.key});

  HomeController homeController = Get.put(HomeController());

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
              homeController.actions(2);
            }
          }, itemBuilder: (BuildContext context) {
            return homeController.labelAction.map((String choice) {
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
                child:
                    HeaderCardWidget(textShow: homeController.message.value)),
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
          onPressed: () {},
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
