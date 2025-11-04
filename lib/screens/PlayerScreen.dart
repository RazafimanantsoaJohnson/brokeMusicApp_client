import "package:brokemusicapp/components/constants.dart";
import "package:brokemusicapp/constants.dart";
import "package:brokemusicapp/models/Tracks.dart";
import "package:brokemusicapp/models/Albums.dart";
import "package:provider/provider.dart";
import "package:brokemusicapp/logics/PlayerBrain.dart";
import "package:flutter/material.dart";


class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {

  @override
  Widget build(BuildContext context) {
    TrackData? currentTrack = Provider.of<PlayerBrain>(context, listen:false).getCurrentTrack();
    AlbumData currentAlbum = Provider.of<PlayerBrain>(context).currentlyPlayingAlbum;
    bool currentPlayStatus = Provider.of<PlayerBrain>(context).currentPlayStatus;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(kPlayerBackground).withAlpha(220),
        actions: [
          Padding(
          padding: EdgeInsets.only(right: kCancelButtonPadding),
          child: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: Icon(
                  Icons.close,
                size: kCancelButtonSize,
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
                  child: Hero(
                    tag: "buttonAlbumCover",
                    child: Image.network(
                        currentAlbum.albumCoverUrl,
                      fit: BoxFit.fill
                    ),
                  ),
                )
              ),
            ),
            Center(
              child: Column(
                spacing: 2.0,
                children: [
                  Text(
                    currentTrack != null?currentTrack.name:"",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    )
                  ),
                  Text(
                      currentAlbum.artistName,
                      style: TextStyle(
                        color: Color(kSecondaryColor).withAlpha(200),
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      )
                  )
                ]
              )
            ),

            SizedBox(height: 64.0),

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
                      onPressed: (){
                        if(currentPlayStatus){
                          Provider.of<PlayerBrain>(context, listen:false).pauseCurrentlyPlayedTrack();
                        }else{
                          Provider.of<PlayerBrain>(context, listen:false).resumeCurrentTrack();
                        }
                      },
                      icon: Icon(
                          currentPlayStatus?Icons.pause:Icons.play_arrow,
                        size: 48.0,
                        color: Colors.white
                      )
                  ),
                ),
                IconButton(
                    onPressed: (){
                      Provider.of<PlayerBrain>(context, listen:false).next();
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

