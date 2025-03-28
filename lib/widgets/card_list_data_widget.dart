import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:scan_qr_app/models/models.dart';

// ignore: must_be_immutable
class CardListDataWidget extends StatelessWidget {
  CardListDataWidget({super.key, required this.listData});
  List<QrDataModel> listData;
  @override
  Widget build(BuildContext context) {
    double heightApp = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: ExpansionPanelList(
        expandedHeaderPadding: const EdgeInsets.only(top: 20, bottom: 20),
        elevation: 3,
        expansionCallback: (panelIndex, isExpanded) {
          listData[panelIndex].isExpanded = isExpanded;
        },
        children: listData.map<ExpansionPanel>((data) {
          return ExpansionPanel(
              isExpanded: true,
              headerBuilder: (context, isExpanded) {
                return ListTile(
                  title: Text(
                    'Registro de Scan QR 🙂‍↔️',
                    style: TextStyle(
                        fontSize: heightApp * 0.02,
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text(
                      'Esto es un registro de escaneo de QR desde la app bro 😎'),
                  leading: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      maxRadius: heightApp * 0.03,
                      child: Icon(
                        FontAwesomeIcons.cashRegister,
                        color: Colors.black,
                        size: heightApp * 0.04,
                      )),
                );
              },
              body: Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 10.0, top: 10.0, bottom: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.value,
                      style: TextStyle(
                          fontSize: heightApp * 0.02,
                          fontWeight: FontWeight.w300),
                    ),
                    ListTile(
                      title: const Text('Fecha de escaneo'),
                      subtitle: Text(
                          'Fecha: ${DateFormat('yyyy/MM/dd hh:mm aaa').format(DateTime.parse(data.createAt).toLocal())}'),
                      leading: const Icon(
                        FontAwesomeIcons.info,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ));
        }).toList(),
      ),
    );
  }
}
