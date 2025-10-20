import 'package:brokemusicapp/screens/MainScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData.light().copyWith(
        primaryColor: Color(0xFFFFFFFF),
        primaryColorDark: Color(0xFFF1F1F1),
      ),
      home: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: MainScreen()
        )
      )
    );
  }
}

