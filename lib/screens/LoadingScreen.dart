import 'package:brokemusicapp/logics/AuthBrain.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  Future<void> navigateToRightScreen() async{
    bool refreshTokenResult = await Provider.of<AuthBrain>(context).refreshAccessToken();
    if (refreshTokenResult){
      Navigator.of(context).pushNamed("/main");
      return;
    }
    Navigator.of(context).pushNamed("/signin");
  }

  @override
  Widget build(BuildContext context) {
    navigateToRightScreen();
    return Scaffold(
      body: Center(
        child: Container(
          height: 100.0,
          width: 100.0,
          child: Image.asset(
              'resources/images/Icon_bma.png',
              fit: BoxFit.scaleDown
          ),
        ),
      )
    );
  }
}

