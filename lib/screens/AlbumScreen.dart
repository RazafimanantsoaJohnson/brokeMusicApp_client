import 'package:brokemusicapp/logics/AuthBrain.dart';
import 'package:brokemusicapp/logics/PlayerBrain.dart';
import 'package:brokemusicapp/logics/Navigation.dart';
import 'package:brokemusicapp/components/AlbumScreenHero.dart';
import 'package:brokemusicapp/constants.dart';
import 'package:flutter/material.dart';
import 'package:brokemusicapp/components/AlbumTitleItem.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:provider/provider.dart';
import 'PlayerScreen.dart';

class AlbumData {
  late String id;
  late String name;
  late String albumType;
  late int totalTracks;
  late String albumUrl;
  late String releaseDate;
  late String releaseDatePrecision;
  late String type;
  late String artistName;
  late String albumCoverUrl;

  AlbumData({required this.id, required this.name, required this.albumType, required this.totalTracks, required this.albumUrl,
  required this.releaseDate, required this.releaseDatePrecision, required this.type, required this.artistName, required this.albumCoverUrl});

  AlbumData.fromJson(Map<String,dynamic> album){
    id = album["id"];
    name = album["name"];
    albumType = album["albumType"];
    totalTracks = album["total_tracks"];
    albumUrl = album["albumUrl"];
    releaseDate = album["release_date"];
    releaseDatePrecision = album["release_date_precision"];
    type = album["type"];
    artistName = album["artist"];
    albumCoverUrl = album["album_cover"];
  }
}

class AlbumScreenProps {
  late String albumCoverUrl;
  late String albumName;
  late String artistName;


  AlbumScreenProps(String cover, String name,String artist){
    albumCoverUrl= cover;
    albumName = name;
    artistName = artist;
  }
}

class AlbumScreen extends StatefulWidget {
  final AlbumScreenProps albumData;
  const AlbumScreen({super.key, required this.albumData});

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

  Future<void> playMusic(player) async{
    try{
      String streamUrl = "";
      // if (numberOfRetry == 0){
      //   streamUrl = "https://rr6---sn-h50gpup0nuxaxjvh-hg0k.googlevideo.com/videoplayback?expire=1760573267&ei=8-LvaIjwKP67vdIP_4TpuQ8&ip=102.115.2.163&id=o-AKa8A7wLavo9bOAIaOt4S1wqEvOQ2APaCHOsi0GW3K9b&itag=140&source=youtube&requiressl=yes&xpc=EgVo2aDSNQ%3D%3D&met=1760551667%2C&mh=7O&mm=31%2C29&mn=sn-h50gpup0nuxaxjvh-hg0k%2Csn-woc7kn7r&ms=au%2Crdu&mv=m&mvi=6&pl=23&rms=au%2Cau&initcwndbps=1852500&bui=ATw7iSXeFBVGDywzSb8Of6TMPt2uFaBopcHMJDZrfxZqW2svAYn2ZPLeOk2iUVa_1Y4hmEfAFu5cMrNW&vprv=1&svpuc=1&mime=audio%2Fmp4&ns=Nz1NkK7ZHYe13shKwWEa6B4Q&rqh=1&gir=yes&clen=2989464&dur=184.645&lmt=1714512200039696&mt=1760551278&fvip=2&keepalive=yes&lmw=1&fexp=51557447%2C51565116%2C51565682%2C51580970&c=TVHTML5&sefc=1&txp=4432434&n=VyQgruI5f4Ce-Q&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cxpc%2Cbui%2Cvprv%2Csvpuc%2Cmime%2Cns%2Crqh%2Cgir%2Cclen%2Cdur%2Clmt&lsparams=met%2Cmh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpl%2Crms%2Cinitcwndbps&lsig=APaTxxMwRAIgM6Bcj6U6JZGyvqfG_JOSRQhI7ImGJ1wc6tsy15g6eZYCIA40s_LUGWv9O34yYO44CyxmsJjc4J7tmTjBPSao7HFD&sig=AJfQdSswRQIhAJbtJtwpyDHPDX5o7y6q_xImDKE940yBTov7ov3jWu4CAiAlLtvntD88DtK0592lrRMv0_Cy-ohxqU59DTV8uxy15w%3D%3D";
      // } else {
      //   print("=====retryyy");
      //   streamUrl = "https://rr4---sn-h50gpup0nuxaxjvh-hg0k.googlevideo.com/videoplayback?expire=1761349444&ei=5Lr7aJmNHrzdp-oPrrC-gAM&ip=102.115.47.222&id=o-AH66nhQcrmq_hpSwekedz0_j0vL0gDqDVZ-la9Gj99Y0&itag=251&source=youtube&requiressl=yes&xpc=EgVo2aDSNQ%3D%3D&met=1761327844%2C&mh=ZE&mm=31%2C29&mn=sn-h50gpup0nuxaxjvh-hg0k%2Csn-4g5edn6y&ms=au%2Crdu&mv=m&mvi=4&pl=22&rms=au%2Cau&gcr=mu&initcwndbps=1563750&bui=AdEuB5R8q7yZuRW7l6WxsbexJNdF14ldM6ndxVlI2CBQXncSrcSfs2kUGGq2V3dHT_d-1e85O8fNTOoP&spc=6b0G_HBJepci&vprv=1&svpuc=1&mime=audio%2Fwebm&rqh=1&gir=yes&clen=3681447&dur=226.341&lmt=1761280345584330&mt=1761327423&fvip=5&keepalive=yes&fexp=51552689%2C51565116%2C51565682%2C51580968&c=ANDROID&txp=4432534&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cxpc%2Cgcr%2Cbui%2Cspc%2Cvprv%2Csvpuc%2Cmime%2Crqh%2Cgir%2Cclen%2Cdur%2Clmt&sig=AJfQdSswRQIhAIsSK0LFCKOM7jNnMbYNiXpuGCQwmSd2tWT99t_TQNAEAiAuRHkM_wuvg9hrMsoXr0LyW_S2fZzdhjvKRC9qT66QWg%3D%3D&lsparams=met%2Cmh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpl%2Crms%2Cinitcwndbps&lsig=APaTxxMwRQIgcNdWEfQhHveJfemoYzmli3seS7wJp1C9cuD8yJPa3WUCIQCwiT31c_fjym1wrDYSdY1Rx1GRNzpRrO23jjOYPYqWjQ%3D%3D";
      // }
      streamUrl = "https://rr4---sn-h50gpup0nuxaxjvh-hg0k.googlevideo.com/videoplayback?expire=1761349444&ei=5Lr7aJmNHrzdp-oPrrC-gAM&ip=102.115.47.222&id=o-AH66nhQcrmq_hpSwekedz0_j0vL0gDqDVZ-la9Gj99Y0&itag=251&source=youtube&requiressl=yes&xpc=EgVo2aDSNQ%3D%3D&met=1761327844%2C&mh=ZE&mm=31%2C29&mn=sn-h50gpup0nuxaxjvh-hg0k%2Csn-4g5edn6y&ms=au%2Crdu&mv=m&mvi=4&pl=22&rms=au%2Cau&gcr=mu&initcwndbps=1563750&bui=AdEuB5R8q7yZuRW7l6WxsbexJNdF14ldM6ndxVlI2CBQXncSrcSfs2kUGGq2V3dHT_d-1e85O8fNTOoP&spc=6b0G_HBJepci&vprv=1&svpuc=1&mime=audio%2Fwebm&rqh=1&gir=yes&clen=3681447&dur=226.341&lmt=1761280345584330&mt=1761327423&fvip=5&keepalive=yes&fexp=51552689%2C51565116%2C51565682%2C51580968&c=ANDROID&txp=4432534&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cxpc%2Cgcr%2Cbui%2Cspc%2Cvprv%2Csvpuc%2Cmime%2Crqh%2Cgir%2Cclen%2Cdur%2Clmt&sig=AJfQdSswRQIhAIsSK0LFCKOM7jNnMbYNiXpuGCQwmSd2tWT99t_TQNAEAiAuRHkM_wuvg9hrMsoXr0LyW_S2fZzdhjvKRC9qT66QWg%3D%3D&lsparams=met%2Cmh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpl%2Crms%2Cinitcwndbps&lsig=APaTxxMwRQIgcNdWEfQhHveJfemoYzmli3seS7wJp1C9cuD8yJPa3WUCIQCwiT31c_fjym1wrDYSdY1Rx1GRNzpRrO23jjOYPYqWjQ%3D%3D";
      // final player = AudioPlayer();
      await player.setSourceUrl(streamUrl);
      await player.resume();
    } catch(e){
      if (numberOfRetry == 0) {
        print("we are replaying");
        numberOfRetry++;
        playMusic(player);
      }
    }
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

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AlbumScreenHero(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 56.0),
              child: FloatingActionButton.extended(
                  onPressed: ()async {
                    // Provider.of<PlayerBrain>(context, listen: false).playAlbum(tTracks);

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
    );
  }


}


