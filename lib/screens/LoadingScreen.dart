import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () async{
            context.loaderOverlay.show();
            await Future.delayed(Duration(seconds: 5));
            context.loaderOverlay.hide();

          },
          child: Text("show loading overlay"),
        )
      ]
    );
  }
}

