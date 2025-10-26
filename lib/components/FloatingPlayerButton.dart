import 'package:brokemusicapp/constants.dart';
import 'package:brokemusicapp/screens/PlayerScreen.dart';
import 'package:flutter/material.dart';

class FloatingPlayerButton extends StatefulWidget {
  const FloatingPlayerButton({super.key});

  @override
  State<FloatingPlayerButton> createState() => _FloatingPlayerButtonState();
}

class _FloatingPlayerButtonState extends State<FloatingPlayerButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context){
                  return PlayerScreen();
                }
            )
        );
      },
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 24.0),
          width: double.infinity,
          height: 68.0,
          child: Material(
            elevation: 8.0,
            shadowColor: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(16.0),
            color: Color(kPlayerBackground).withAlpha(200),//Theme.of(context).colorScheme.primaryContainer,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [

                    Expanded(
                      child: Row(
                        spacing: 16.0,
                        children: [
                          SizedBox(
                            width: 60.0,
                            height: 60.0,
                            child: Image.network(
                              "https://i.scdn.co/image/ab67616d0000b273c5649add07ed3720be9d5526",
                              fit: BoxFit.contain,
                            ),
                          ),
                          Text(
                              "Nikes",
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.white
                              )
                          )
                        ],
                      ),
                    ),

                    IconButton(
                      icon: Icon(
                          Icons.pause,
                        color: Colors.white,
                      ),
                      onPressed: (){
                        // pause/play the current playing song
                      },
                    )
                  ]
              ),
            ),
          )
      ),
    );
  }
}
