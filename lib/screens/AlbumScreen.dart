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
  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();

    // for(int i =0; i<ttracks.length; i++){
    //   tTracks.add(TrackData.fromJson(ttracks[i]));
    // }
  }

  List<Widget> showListOfTracks(){
    List<TrackData> tracks = Provider.of<NavigationBrain>(context, listen:false).tracks;
    if (tracks.length == 0){
      return [];
    }
    List<Widget> listOfTracks = [];
    for (int i=0; i<tracks.length; i++){
      listOfTracks.add(AlbumTitleItem(track: tracks[i]));
    }
    return listOfTracks;
  }

  @override
  Widget build(BuildContext context) {
    AlbumData album= Provider.of<NavigationBrain>(context).albumData;
    String authToken = Provider.of<AuthBrain>(context).accessToken;
    List<TrackData> tracks = Provider.of<NavigationBrain>(context).tracks;

    return SafeArea(
      child: Stack(
        children: [
          SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AlbumScreenHero(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 56.0),
                child: FloatingActionButton.extended(
                    onPressed: ()async {
                      Provider.of<PlayerBrain>(context, listen: false).playAlbum(authToken, album,tracks);

                      setState((){
                        isSongPlaying= !isSongPlaying;
                      });

                    },
                  backgroundColor: Colors.white,
                    label: Text(
                        "Play",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 18.0,
                      )
                    ),
                  icon: Icon(
                    Icons.play_arrow_rounded,
                    size: 40.0,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 32.0),

              IconButton(onPressed: (){
                Provider.of<PlayerBrain>(context, listen:false).next();
              }, icon: Icon(Icons.skip_next)),
              IconButton(onPressed: (){
                Provider.of<PlayerBrain>(context, listen:false).pauseCurrentlyPlayedTrack();
              }, icon: Icon(Icons.pause_circle_filled)),
              IconButton(onPressed: () async {
                await Provider.of<AuthBrain>(context, listen:false).signin("email", "beybey");
              }, icon: Icon(Icons.ac_unit_rounded)),
              Container(
                color: Color(kSecondaryColor),
                child: Column(
                  children: showListOfTracks(),
                )
              ),

              SizedBox(height: 72.0)
            ],
          ),
        ),
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
        ]
      ),
    );
  }


}


