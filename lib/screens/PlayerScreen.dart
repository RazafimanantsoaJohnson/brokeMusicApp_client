import "package:brokemusicapp/components/constants.dart";
import "package:brokemusicapp/constants.dart";
import "package:flutter/material.dart";


class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(kPlayerBackground).withAlpha(220),
        actions: [
          Padding(
          padding: EdgeInsets.only(right: 24.0),
          child: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: Icon(
                  Icons.close,
                size: 32.0,
                color: Colors.white,
              )
          ),
        )
        ],
      ),
      backgroundColor: Colors.white,
      body: Container(
        color:  Color(kPlayerBackground).withAlpha(210),
        padding: EdgeInsets.only(bottom: 100.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Center(
              child: Container(
                margin: EdgeInsets.only(top: 20.0, bottom: 32.0),
                width: 280.0,
                height: 320.0,
                foregroundDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(kPlayerCoverBorderRadius),

                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(kPlayerCoverBorderRadius),
                  child: Image.network(
                      "https://i.scdn.co/image/ab67616d0000b273c5649add07ed3720be9d5526",
                    fit: BoxFit.fill
                  ),
                )
              ),
            ),
            Center(
              child: Column(
                spacing: 2.0,
                children: [
                  Text(
                    "Nikes",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    )
                  ),
                  Text(
                      "Frank Ocean",
                      style: TextStyle(
                        color: Color(kSecondaryColor).withAlpha(200),
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      )
                  )
                ]
              )
            ),

            SizedBox(height: 100.0),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 24.0,
              children: [
                IconButton(
                    onPressed: (){},
                    icon: Icon(
                      Icons.skip_previous,
                      size: 48.0,
                      color: Colors.white,
                    ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                    color: Colors.white.withAlpha(100),
                  ),
                  padding: EdgeInsets.all(8.0),
                  child: IconButton(
                      onPressed: (){},
                      icon: Icon(
                          Icons.pause,
                        size: 48.0,
                        color: Colors.white
                      )
                  ),
                ),
                IconButton(
                    onPressed: (){

                    },
                    icon: Icon(
                        Icons.skip_next,
                      size: 48.0,
                      color: Colors.white
                    )
                ),
              ],
            )
          ]
        ),
      ),
    );
  }
}

