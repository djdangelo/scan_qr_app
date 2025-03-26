import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [],
      child: MaterialApp(
        darkTheme: ThemeData.light(useMaterial3: false),
        theme: ThemeData.light(useMaterial3: false),
        debugShowCheckedModeBanner: false,
        title: 'Scan QR',
        initialRoute: '/',
      ),
    );
  }
}
