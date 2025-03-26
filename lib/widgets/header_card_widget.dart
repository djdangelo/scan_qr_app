import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HeaderCardWidget extends StatelessWidget {
  HeaderCardWidget({super.key, required this.textShow});
  String textShow;
  @override
  Widget build(BuildContext context) {
    double heightApp = MediaQuery.of(context).size.height;
    double withApp = MediaQuery.of(context).size.width;
    return Card(
      color: Colors.black,
      elevation: 3.0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(1.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
            child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
                tag: 'home',
                child: CircleAvatar(
                  backgroundImage: const AssetImage('assets/images/cool.png'),
                  backgroundColor: Colors.transparent,
                  radius: heightApp * 0.04,
                )),
            SizedBox(
              width: heightApp * 0.02,
            ),
            SizedBox(
              width: withApp * 0.65,
              child: Text(
                textShow,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: heightApp * 0.03,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
