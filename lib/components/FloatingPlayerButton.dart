import 'package:brokemusicapp/constants.dart';
import 'package:brokemusicapp/logics/PlayerBrain.dart';
import 'package:brokemusicapp/models/Albums.dart';
import 'package:brokemusicapp/models/Tracks.dart';
import 'package:brokemusicapp/screens/PlayerScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FloatingPlayerButton extends StatefulWidget {
  const FloatingPlayerButton({super.key});

  @override
  State<FloatingPlayerButton> createState() => _FloatingPlayerButtonState();
}

class _FloatingPlayerButtonState extends State<FloatingPlayerButton> {
  @override
  Widget build(BuildContext context) {
    TrackData? currentTrack = Provider.of<PlayerBrain>(context, listen:false).getCurrentTrack();

    if (currentTrack == null){
      return SizedBox(height:0);
    }
    AlbumData currentAlbum = Provider.of<PlayerBrain>(context).currentlyPlayingAlbum;
    bool currentPlayStatus = Provider.of<PlayerBrain>(context).currentPlayStatus;

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
                              child: Hero(
                                tag: "currentAlbumCover",
                                child: Image.network(
                                  currentAlbum.albumCoverUrl,
                                  fit: BoxFit.contain,
                                ),
                              ),
                          ),
                          Text(
                              currentTrack.name,
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
                          currentPlayStatus? Icons.pause:Icons.play_arrow,
                        color: Colors.white,
                      ),
                      onPressed: (){
                        // pause/play the current playing song
                        if (!currentPlayStatus){
                          Provider.of<PlayerBrain>(context, listen:false).resumeCurrentTrack();
                        }else{
                          Provider.of<PlayerBrain>(context, listen:false).pauseCurrentlyPlayedTrack();
                        }
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
