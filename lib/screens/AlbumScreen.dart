import 'package:brokemusicapp/components/constants.dart';
import 'package:brokemusicapp/logics/AuthBrain.dart';
import 'package:brokemusicapp/logics/PlayerBrain.dart';
import 'package:brokemusicapp/logics/Navigation.dart';
import 'package:brokemusicapp/components/AlbumScreenHero.dart';
import 'package:brokemusicapp/constants.dart';
import 'package:flutter/material.dart';
import 'package:brokemusicapp/components/AlbumTitleItem.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:brokemusicapp/models/Albums.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:brokemusicapp/models/Tracks.dart';



class AlbumScreen extends StatefulWidget {
  // final AlbumScreenProps albumData;
  const AlbumScreen({super.key});

  @override
  State<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  int numberOfRetry = 0;
  bool isSongPlaying = false;

  @override
  void initState() {
    super.initState();

    // for(int i =0; i<ttracks.length; i++){
    //   tTracks.add(TrackData.fromJson(ttracks[i]));
    // }
  }

  List<Widget> showListOfTracks(AlbumData album){
    List<TrackData> tracks = Provider.of<NavigationBrain>(context, listen:false).tracks;
    if (tracks.length == 0){
      return [];
    }
    List<Widget> listOfTracks = [];
    for (int i=0; i<tracks.length; i++){
      listOfTracks.add(AlbumTitleItem(track: tracks[i], album: album, allTracks: tracks));
    }
    return listOfTracks;
  }

  @override
  Widget build(BuildContext context) {
    AlbumData album= Provider.of<NavigationBrain>(context).albumData;
    String authToken = Provider.of<AuthBrain>(context).accessToken;
    List<TrackData> tracks = Provider.of<NavigationBrain>(context).tracks;
    AlbumData? currentlyPlayedAlbum = Provider.of<PlayerBrain>(context, listen: false).getCurrentlyPlayedAlbum();
    bool currentPlayStatus = Provider.of<PlayerBrain>(context).currentPlayStatus;
    bool isAlbumCurrentlyPlayed = (currentlyPlayedAlbum!=null && currentlyPlayedAlbum.id == album.id && currentPlayStatus);

    return SafeArea(
      child: Stack(
        children: [
          SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: kCancelButtonPadding),
                    child: IconButton(onPressed: (){
                      Provider.of<NavigationBrain>(context, listen: false).hideAlbumScreen();
                    },
                        icon: Icon(
                          Icons.close,
                          size: kCancelButtonSize,
                          color: Colors.black,
                        )
                    ),
                  ),
                ],
              ),
              AlbumScreenHero(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 56.0),
                child: FloatingActionButton.extended(
                    onPressed: ()async {
                      if (isAlbumCurrentlyPlayed){
                        await Provider.of<PlayerBrain>(context, listen:false).pauseCurrentlyPlayedTrack();
                      }else{
                        context.loaderOverlay.show();
                        await Provider.of<PlayerBrain>(context, listen: false).playAlbum(authToken, album,tracks, 0);
                        context.loaderOverlay.hide();
                      }

                      setState((){
                        isSongPlaying= !isSongPlaying;
                      });

                    },
                  backgroundColor: Colors.white,
                    label: Text(
                        isAlbumCurrentlyPlayed?"Pause":"Play",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 18.0,
                      )
                    ),
                  icon: Icon(
                    isAlbumCurrentlyPlayed?Icons.pause:Icons.play_arrow_rounded,
                    size: 40.0,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 32.0),

              Container(
                color: Color(kSecondaryColor),
                child: Column(
                  children: showListOfTracks(album),
                )
              ),

              SizedBox(height: 72.0)
            ],
          ),
        ),
        ]
      ),
    );
  }
}


