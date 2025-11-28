import 'package:brokemusicapp/logics/AuthBrain.dart';
import 'package:brokemusicapp/logics/Navigation.dart';
import 'package:brokemusicapp/logics/PlayerBrain.dart';
import 'package:brokemusicapp/screens/MainScreen.dart';
import 'package:brokemusicapp/screens/SigninScreen.dart';
import 'package:brokemusicapp/screens/SignupScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glass_morphism/flutter_glass_morphism.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PlayerBrain()),
        ChangeNotifierProvider(create: (_) => AuthBrain()),
        ChangeNotifierProvider(create: (_)=> NavigationBrain()),

      ],
      child: GlassMorphismThemeProvider(
        child: MaterialApp(
          routes: {
            '/': (context) => SigninScreen(),
            '/signup': (context) => SignupScreen(),
            '/main': (context) => MainScreen(),
          },
          theme: ThemeData.light().copyWith(
            primaryColor: Color(0xFFFFFFFF),
            primaryColorDark: Color(0xFFF1F1F1),
          ),
          // home: LoaderOverlay(
          //   child: Scaffold(
          //     body: Container(
          //       width: double.infinity,
          //       height: double.infinity,
          //       child: MainScreen()
          //     )
          //   ),
          // )
        ),
      ),
    );
  }
}

